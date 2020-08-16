cask "textmate-fish" do
  version :latest
  sha256 :no_check

  url "https://github.com/sanssecours/Fish.tmbundle/archive/master.tar.gz"
  name "Fish for TextMate"
  homepage "https://github.com/sanssecours/Fish.tmbundle"

  artifact "Fish.tmbundle-master",
           target: "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles/Fish.tmbundle"
end
