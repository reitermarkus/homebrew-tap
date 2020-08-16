cask "textmate-chapel" do
  version :latest
  sha256 :no_check

  url "https://github.com/chapel-lang/chapel-tmbundle/archive/master.tar.gz"
  name "Chapel for TextMate"
  homepage "https://github.com/chapel-lang/chapel-tmbundle"

  artifact "chapel-tmbundle-master",
           target: "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles/Chapel.tmbundle"
end
