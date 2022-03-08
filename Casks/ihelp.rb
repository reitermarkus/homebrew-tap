cask "ihelp" do
  version "2.0.1"
  sha256 :no_check

  url "https://github.com/reitermarkus/mirror/raw/HEAD/iHelp.zip"
  name "iHelp"
  homepage "http://www.rmartijnr.eu/iHelp/index.html"

  app "iHelp.app"

  caveats do
    discontinued
  end
end
