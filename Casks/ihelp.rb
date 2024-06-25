cask "ihelp" do
  version "2.0.1"
  sha256 :no_check

  url "https://github.com/reitermarkus/mirror/raw/HEAD/iHelp.zip",
      verified: "github.com/reitermarkus/mirror/"
  name "iHelp"
  homepage "https://web.archive.org/web/20231003180144/http://www.rmartijnr.eu/ihelp.html"

  deprecate! date: "2016-01-01", because: :discontinued

  app "iHelp.app"
end
