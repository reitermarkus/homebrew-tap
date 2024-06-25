cask "itest" do
  version "1.1.0"
  sha256 :no_check

  url "https://github.com/reitermarkus/mirror/raw/HEAD/iTest.zip",
      verified: "github.com/reitermarkus/mirror/"
  name "iTest"
  homepage "https://web.archive.org/web/20230606095017/http://www.rmartijnr.eu/itest.html"

  deprecate! date: "2016-01-01", because: :discontinued

  app "iTest.app"
end
