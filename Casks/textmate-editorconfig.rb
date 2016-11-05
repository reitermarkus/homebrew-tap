cask 'textmate-editorconfig' do
  version '0.2.5'
  sha256 'b046a33772396277915618f3d821445ecccafe269f82ee1b2adefcdb9088115d'

  url "https://github.com/Mr0grog/editorconfig-textmate/releases/download/v#{version}/editorconfig-textmate-#{version}.tar.gz"
  appcast 'https://github.com/Mr0grog/editorconfig-textmate/releases.atom',
          checkpoint: '383f3712d5a3fe4516fcc79350c7572ae00adc28530683993ec7d36e6556206c'
  name 'EditorConfig Plugin for TextMate'
  homepage 'https://github.com/Mr0grog/editorconfig-textmate'

  plugin_name = 'editorconfig-textmate.tmplugin'
  textmate_bundles = File.expand_path('~/Library/Application Support/TextMate/Managed/Bundles/')

  postflight do
    FileUtils.mkdir_p textmate_bundles
    FileUtils.rm_rf File.join(textmate_bundles, plugin_name)
    FileUtils.mv staged_path.join(plugin_name), textmate_bundles
  end

  uninstall_postflight do
    FileUtils.rm_rf File.join(textmate_bundles, plugin_name)
  end
end
