cask "iconvert" do
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/reitermarkus/mirror/raw/HEAD/iConvert.zip",
      verified: "github.com/reitermarkus/mirror/"
  name "iConvert"
  homepage "https://web.archive.org/web/20231002175808/http://www.rmartijnr.eu/iconvert.html"

  deprecate! date: "2016-01-01", because: :discontinued

  app "iConvert.app"
end
