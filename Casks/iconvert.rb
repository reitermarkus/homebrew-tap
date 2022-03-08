cask "iconvert" do
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/reitermarkus/mirror/raw/HEAD/iConvert.zip"
  name "iConvert"
  homepage "http://www.rmartijnr.eu/iconvert.html"

  app "iConvert.app"

  caveats do
    discontinued
  end
end
