cask "ilearn" do
  version "1.3.3"
  sha256 :no_check

  url "https://github.com/reitermarkus/mirror/raw/HEAD/iLearn.zip",
      verified: "https://github.com/reitermarkus/mirror/"
  name "iLearn"
  homepage "http://www.rmartijnr.eu/iLearn/index.html"

  app "iLearn.app"

  caveats do
    discontinued
  end
end
