cask "textmate-javascript-babel" do
  version :latest
  sha256 :no_check

  url "https://github.com/ravasthi/javascript-babel.tmbundle/archive/main.tar.gz"
  name "JavaScript (Babel) Plugin for TextMate"
  homepage "https://github.com/ravasthi/javascript-babel.tmbundle"

  artifact "javascript-babel.tmbundle-main",
           target: "~/Library/Application Support/TextMate/Bundles/JavaScript (Babel).tmbundle"
end
