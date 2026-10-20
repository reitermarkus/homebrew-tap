# typed: false
# frozen_string_literal: true

require "cli/parser"
require "io/console"

module Homebrew

  module Cmd
    class Review < AbstractCommand
      include SystemCommand::Mixin

      cmd_args do
        description <<~EOS
          Review open pull requests
        EOS

        switch "--dry-run", description: "Don't send approval requests."
        switch "--browser", description: "Show pull requests in browser instead of terminal."
        switch "--only-bumps", description: "Only bumps."
        switch "--only-official", description: "Only BrewTestBot PRs."

        named_args :tap, min: 1
      end

      private def with_raw_tty
        system "stty", "raw", "-echo"

        yield
      ensure
        system "stty", "-raw", "echo"
      end

      private def enable_auto_merge(pull_request)
        title = pull_request.fetch("title")
        number = pull_request.fetch("number")
        node_id = pull_request.fetch("id")
        sha = pull_request.fetch("headRef").fetch("target").fetch('oid')

        headline = "#{title} (##{number})"

        query = <<~EOS
          mutation {
            enablePullRequestAutoMerge(input: {
              pullRequestId: #{node_id.inspect},
              commitHeadline: #{headline.inspect},
              commitBody: "\\n",
              expectedHeadOid: #{sha.inspect},
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

      private def open_tab(url)
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

      def fetch_pull_requests(tap)
        query = <<~EOS
          query($owner: String!, $repo: String!, $states: [PullRequestState!], $after: String) {
            repository(owner: $owner, name: $repo) {
              pullRequests(states: $states, first: 100, after: $after) {
                nodes {
                  id
                  number
                  author {
                    login
                  }
                  title
                  body
                  isDraft
                  labels(first: 100) {
                    nodes {
                      name
                    }
                  }
                  url
                  headRef {
                    target {
                      oid
                    }
                  }
                  reviews(last: 100) {
                    nodes {
                      author {
                        login
                      }
                      state
                      commit {
                        oid
                      }
                    }
                  }
                }
                pageInfo {
                  hasNextPage
                  endCursor
                }
              }
            }
          }
        EOS
        owner, repo = tap.full_name.split("/")
        variables = { owner:, repo:, states: ["OPEN"] }

        pull_requests = []
        GitHub::API.paginate_graphql(query, variables:) do |result|
          data = result.dig("repository", "pullRequests")
          pull_requests.concat(data["nodes"])
          data["pageInfo"]
        end
        pull_requests
      end

      private def review_pr(pr, args:)
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

      private def approve_pr(pr, args:)
        number = pr.fetch("number")

        if args.dry_run?
          puts "✅ Pull request #{number} would have been approved."
        else
          enable_auto_merge(pr)

          url = pr.fetch("url").sub('https://github.com/', 'https://api.github.com/repos/').sub('/pull/', '/pulls/')

          GitHub::API.open_rest(
            "#{url}/reviews",
            data:           {
              commit_id: pr.fetch("headRef").fetch("target").fetch('oid'),
              event:     "APPROVE",
            },
            request_method: :POST,
          )

          puts "✅ Pull request #{number} approved."
        end
      end

      sig { override.void }
      def run
        taps = args.named.map { |t| Tap.fetch(t) }

        current_user = GitHub.user.fetch("login")

        taps.each do |tap|
          pull_requests = fetch_pull_requests(tap).sort_by { |pr| -pr.fetch('number') }

          $stdin.sync = true

          pull_requests.each do |pr|
            number = pr.fetch("number")
            sha = pr.fetch("headRef").fetch("target").fetch('oid')
            html_url = pr.fetch("url")
            html_files_url = "#{html_url}/files/#{sha}"

            author = pr.fetch("author").fetch("login")

            # Cannot approve one's own pull requests.
            next if author == current_user

            next if args.only_official? && author != "BrewTestBot"

            reviews = pr.fetch('reviews').fetch('nodes')
            reviews_for_sha = reviews.select do |review|
              review.fetch("state") != "DISMISSED" &&
              review.fetch("commit").fetch('oid') == sha
            end

            if reviews_for_sha.any? { |review| review.fetch('state') == 'APPROVED' }
              puts "Pull request ##{number} already approved."
              next
            end

            user_reviews_for_sha = reviews_for_sha.select { |review| review.fetch("author").fetch("login") == current_user }

            # Draft PRs cannot be merged.
            next if pr.fetch("isDraft")

            labels = pr.fetch("labels").fetch('nodes').map { |l| l.fetch("name") }
            next if args.only_bumps? && !labels.include?('bump-cask-pr')

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

              diff_url = "#{pr.fetch("url")}.diff"
              diff = GitHub::API.open_rest(diff_url, parse_json: false)

              puts
              if Homebrew::EnvConfig.bat?
                ENV["BAT_CONFIG_PATH"] = Homebrew::EnvConfig.bat_config_path
                ENV["BAT_THEME"] = Homebrew::EnvConfig.bat_theme

                bat = Formula["bat"].ensure_installed!(
                  reason:           "displaying <formula>/<cask> source",
                  # The user might want to capture the output of `brew cat ...`
                  # Redirect stdout to stderr
                  output_to_stderr: true,
                  executable:       "bat",
                )

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
  end
end
