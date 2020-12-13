cask "textmate-typescript" do
  version :latest
  sha256 :no_check

  url "https://raw.githubusercontent.com/stanger/TypeScript-TextMate/HEAD/dist/TypeScript.tmbundle.zip"
  name "TypeScript for TextMate"
  homepage "https://github.com/stanger/TypeScript-TextMate"

  plugin_name = "TypeScript.tmbundle"

  artifact plugin_name,
           target: "~/Library/Application Support/TextMate/Bundles/TypeScript.tmbundle"
end
