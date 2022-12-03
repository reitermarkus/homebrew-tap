cask "textmate-openhab" do
  version :latest
  sha256 :no_check

  url "https://github.com/reitermarkus/OpenHAB.tmbundle/archive/master.tar.gz"
  name "OpenHAB for TextMate"
  homepage "https://github.com/reitermarkus/OpenHAB.tmbundle"

  plugin_name = "OpenHAB.tmbundle"

  artifact "#{plugin_name}-master",
           target: "#{Dir.home}/Library/Application Support/TextMate/Bundles/#{plugin_name}"
end
