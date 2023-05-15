cask "textmate-crystal" do
  version :latest
  sha256 :no_check

  url "https://github.com/huacnlee/Crystal.tmbundle/archive/master.tar.gz"
  name "Crystal Plugin for TextMate"
  homepage "https://github.com/huacnlee/Crystal.tmbundle"

  plugin_name = "Crystal.tmbundle"

  artifact "#{plugin_name}-master",
           target: "~/Library/Application Support/TextMate/Bundles/#{plugin_name}"
end
