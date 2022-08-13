# typed: false
# frozen_string_literal: true

require "cli/parser"
require "io/console"

module Homebrew
  extend T::Sig

  module_function

  sig { returns(CLI::Parser) }
  def review_args
    Homebrew::CLI::Parser.new do
      description <<~EOS
        Review open pull requests.
      EOS

      switch "-d", "--dry-run", description: "Don't send approval requests."
      named_args :tap, min: 1
    end
  end

  def with_raw_tty
      system "stty", "raw", "-echo"

      yield
    ensure
      system "stty", "-raw", "echo"
  end

  def enable_auto_merge(pull_request)
    title = pull_request.fetch("title")
    number = pull_request.fetch("number")
    node_id = pull_request.fetch("node_id")

    headline = "#{title} (##{number})"

    query = <<~EOS
      mutation {
        enablePullRequestAutoMerge(input: {
          pullRequestId: #{node_id.inspect},
          commitHeadline: #{headline.inspect},
          commitBody: "\\n",
          mergeMethod: SQUASH,
        }) {
          pullRequest {
            autoMergeRequest {
              enabledAt
              enabledBy {
                login
              }
            }
          }
        }
      }
    EOS

    GitHub::API.open_graphql(query)
  end

  def open_tab(url)
    system_command! OS::PATH_OPEN, args: ["-g", url]

    sleep 1

    tab_name = system_command!("osascript", args: [
      "-e",
      <<~APPLESCRIPT,
        tell application "Safari"
          set currentTab to current tab of front window
          get name of currentTab
        end tell
      APPLESCRIPT
    ]).stdout.chomp

    yield
  ensure
    system_command! "osascript", args: [
      "-e",
      <<~APPLESCRIPT,
        tell application "Safari"
          close (every tab of first window where the name is #{tab_name.inspect})
        end tell
      APPLESCRIPT
    ]
  end

  def review
    args = review_args.parse

    taps = args.named.map { |t| Tap.fetch(t) }

    taps.each do |tap|
      pull_requests = GitHub.pull_requests(tap.full_name, state: :open, per_page: 100)

      $stdin.sync = true

      pull_requests.each do |pr|
        # puts JSON.pretty_generate(pr)

        number = pr.fetch("number")
        sha = pr.fetch("head").fetch("sha")
        html_url = pr.fetch("_links").fetch("html").fetch("href").to_s
        html_files_url = "#{html_url}/files/#{sha}"

        reviews_url = "#{pr.fetch("url")}/reviews"
        reviews = GitHub::API.open_rest(reviews_url)
        user_reviews_for_sha = reviews.select do |review|
          review.fetch("user").fetch("login") == GitHub.user.fetch("login") &&
            review.fetch("state") != "DISMISSED" &&
            review.fetch("commit_id") == sha
        end

        files_url = "#{pr.fetch("url")}/reviews"
        files = GitHub::API.open_rest(reviews_url)

        if user_reviews_for_sha.any?
          puts "Pull request ##{number} already reviewed."
          next
        end

        print "Opening pull request ##{number}."

        open_tab html_files_url do
          sleep 3

          with_raw_tty do
            loop do
              $stdin.read_nonblock(1)
            rescue IO::EAGAINWaitReadable
              break
            end
          end

          print "\rApprove pull request ##{number}? "

          input = with_raw_tty { $stdin.getc }
          case input
          when "\u0003"
            raise Interrupt
          when "\r", "\n"
            open_tab(html_url) do
              puts

              cancelled = false
              (0..3).each do |i|
                puts "Approving in #{i}, press any key to cancel.\r"

                sleep 1

                with_raw_tty do
                  begin
                    c = $stdin.read_nonblock(1)

                    # Some key was pressed, so cancel.
                    cancelled = true
                  rescue IO::EAGAINWaitReadable
                  end
                end

                break if cancelled
              end


              if cancelled
                puts "❌ Approval cancelled."
                next
              end

              if args.dry_run?
                puts "✅ Pull request #{number} would have been approved."
              else
                # enable_auto_merge(pr)

                GitHub::API.open_rest(
                  reviews_url,
                  data:           {
                    commit_id: sha,
                    event:     "APPROVE",
                  },
                  request_method: :POST,
                )

                puts "✅ Pull request #{number} approved."
              end

              sleep 5
            end
          else
            puts "❌ Pull request #{number} not approved."
          end
        end
      end
    end
  end
end
