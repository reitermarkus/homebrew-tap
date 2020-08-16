cask "textmate-solarized" do
  version :latest
  sha256 :no_check

  url "https://github.com/reitermarkus/Solarized.tmbundle/archive/master.tar.gz"
  name "Solarized Theme for TextMate"
  homepage "https://github.com/reitermarkus/Solarized.tmbundle"

  plugin_name = "Solarized.tmbundle"

  artifact plugin_name, target: "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles/#{plugin_name}"

  preflight do
    FileUtils.mv staged_path / "#{plugin_name}-master", staged_path / plugin_name
  end
end
