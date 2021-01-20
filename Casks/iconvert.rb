cask "iconvert" do
  version "1.0.0"
  sha256 "b598453a1f0ae9a8ed36930f9ceee0af209f0833850db41403ae1572ce9dc51f"

  url "https://github.com/reitermarkus/mirror/raw/master/iConvert.zip" # rubocop:disable Cask/HomepageMatchesUrl
  name "iConvert"
  homepage "http://www.rmartijnr.eu/iconvert.html"

  app "iConvert.app"

  caveats do
    discontinued
  end
end
