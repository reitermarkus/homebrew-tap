cask "ilearn" do
  version "1.3.3"
  sha256 "06b8db063df075efda1b29384333d25f5b8aaf809dea476576a030f13003c811"

  url "https://github.com/reitermarkus/mirror/raw/master/iLearn.zip" # rubocop:disable Cask/HomepageMatchesUrl
  name "iLearn"
  homepage "http://www.rmartijnr.eu/iLearn/index.html"

  app "iLearn.app"
end
