cask "textmate-javascript-babel" do
  version :latest
  sha256 :no_check

  url "https://github.com/ravasthi/javascript-babel.tmbundle/archive/master.tar.gz"
  name "JavaScript (Babel) Plugin for TextMate"
  homepage "https://github.com/ravasthi/javascript-babel.tmbundle"

  artifact "javascript-babel.tmbundle-master",
           target: "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles/JavaScript (Babel).tmbundle"
end
