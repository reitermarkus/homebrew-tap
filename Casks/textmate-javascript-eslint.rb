cask "textmate-javascript-eslint" do
  version "3.0.2"
  sha256 "df11f0261cf7e08fcaa7f61918f936ce9c4742ed29ee068ee3b522b08df147eb"

  url "https://github.com/natesilva/javascript-eslint.tmbundle/releases/download/v#{version}/javascript-eslint.tmbundle.zip"
  name "JavaScript ESLint for TextMate"
  homepage "https://github.com/natesilva/javascript-eslint.tmbundle"

  plugin_name = "javascript-eslint.tmbundle"

  artifact plugin_name,
           target: "~/Library/Application Support/TextMate/Bundles/JavaScript ESLint.tmbundle"

  preflight do
    files = Dir.glob("#{staged_path}/*")
    plugin_path = staged_path.join(plugin_name)
    plugin_path.mkpath
    FileUtils.mv files, plugin_path
  end
end
