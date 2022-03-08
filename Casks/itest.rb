cask "itest" do
  version "1.1.0"
  sha256 :no_check

  url "https://github.com/reitermarkus/mirror/raw/HEAD/iTest.zip"
  name "iTest"
  homepage "http://www.rmartijnr.eu/iTest/index.html"

  app "iTest.app"

  caveats do
    discontinued
  end
end
