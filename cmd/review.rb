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
      switch "--browser", description: "Show pull requests in browser instead of terminal."
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

  def review_pr(pr, args:)
    with_raw_tty do
      loop do
        $stdin.read_nonblock(1)
      rescue IO::EAGAINWaitReadable
        break
      end
    end

    number = pr.fetch("number")
    print "\rApprove pull request ##{number}? "

    input = with_raw_tty { $stdin.getc }
    case input
    when "\u0003"
      raise Interrupt
    when "\r", "\n"
      if args.browser?
        open_tab(html_url) do
          approve_pr(pr, args: args)

          sleep 5
        end
      else
        approve_pr(pr, args: args)
      end
    else
      puts "❌ Pull request #{number} not approved."
    end
  end

  def approve_pr(pr, args:)
    number = pr.fetch("number")

    if args.dry_run?
      puts "✅ Pull request #{number} would have been approved."
    else
      enable_auto_merge(pr)

      GitHub::API.open_rest(
        "#{pr.fetch("url")}/reviews",
        data:           {
          commit_id: pr.fetch("head").fetch("sha"),
          event:     "APPROVE",
        },
        request_method: :POST,
      )

      puts "✅ Pull request #{number} approved."
    end
  end

  def review
    args = review_args.parse

    taps = args.named.map { |t| Tap.fetch(t) }

    taps.each do |tap|
      pull_requests = GitHub.pull_requests(tap.full_name, state: :open, per_page: 100)

      $stdin.sync = true

      pull_requests.each do |pr|
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

        # Draft PRs cannot be merged.
        next if pr.fetch("draft")

        labels = pr.fetch("labels").map { |l| l.fetch("name") }

        if user_reviews_for_sha.any?
          puts "Pull request ##{number} already reviewed."
          next
        end

        if args.browser?
          print "Opening pull request ##{number}."

          open_tab html_files_url do
            review_pr(pr, args: args)
          end
        else
          title = pr.fetch("title")
          body = pr.fetch("body")

          diff_url = pr.fetch("diff_url")
          diff = GitHub::API.open_rest(diff_url, parse_json: false)

          puts
          if Homebrew::EnvConfig.bat?
            ENV["BAT_CONFIG_PATH"] = Homebrew::EnvConfig.bat_config_path
            ENV["BAT_THEME"] = Homebrew::EnvConfig.bat_theme
            bat = ensure_formula_installed!(
              "bat",
              reason:           "displaying <formula>/<cask> source",
              # The user might want to capture the output of `brew cat ...`
              # Redirect stdout to stderr
              output_to_stderr: true,
            ).opt_bin/"bat"

            out, = system_command! bat,
                                   args: ["--paging", "never", "--language", "markdown", "--color", "always", "--style", "plain"], input: <<~EOS
                                     # #{title}

                                     #{body}
                                   EOS
            puts out.chomp
            puts

            out, = system_command!(bat,
                                   args: ["--paging", "never", "--language", "diff", "--color", "always", "--style", "plain"], input: diff)
            puts out.chomp
          else
            puts "# #{title}"
            puts
            puts body
            puts
            puts diff
          end
          puts

          review_pr(pr, args: args)
        end
      end
    end
  end
end
