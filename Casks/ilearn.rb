cask "ilearn" do
  version "1.3.3"
  sha256 :no_check

  url "https://github.com/reitermarkus/mirror/raw/HEAD/iLearn.zip",
      verified: "github.com/reitermarkus/mirror/"
  name "iLearn"
  homepage "https://web.archive.org/web/20240224113726/http://www.rmartijnr.eu/ilearn.html"

  deprecate! date: "2016-01-01", because: :discontinued

  app "iLearn.app"
end
