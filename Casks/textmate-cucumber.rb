cask "textmate-cucumber" do
  version :latest
  sha256 :no_check

  url "https://github.com/cucumber/cucumber-tmbundle/archive/master.tar.gz"
  name "Crystal Plugin for TextMate"
  homepage "https://github.com/cucumber/cucumber-tmbundle"

  plugin_name = "Cucumber.tmbundle"

  artifact "cucumber-tmbundle-master",
           target: "~/Library/Application Support/TextMate/Bundles/#{plugin_name}"
end
