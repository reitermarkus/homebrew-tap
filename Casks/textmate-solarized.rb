cask "textmate-solarized" do
  version :latest
  sha256 :no_check

  url "https://github.com/reitermarkus/Solarized.tmbundle/tarball/HEAD"
  name "TextMate Solarized Theme"
  desc "Text editor color theme"
  homepage "https://github.com/reitermarkus/Solarized.tmbundle"

  plugin_name = "Solarized.tmbundle"

  artifact plugin_name, target: "~/Library/Application Support/TextMate/Bundles/#{plugin_name}"

  preflight do
    plugin_path = staged_path.children.first
    FileUtils.mv plugin_path, staged_path / plugin_name
  end
end
