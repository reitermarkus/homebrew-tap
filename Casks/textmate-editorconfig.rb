cask 'textmate-editorconfig' do
  version '0.2.5'
  sha256 'b046a33772396277915618f3d821445ecccafe269f82ee1b2adefcdb9088115d'

  url "https://github.com/Mr0grog/editorconfig-textmate/releases/download/v#{version}/editorconfig-textmate-#{version}.tar.gz"
  appcast 'https://github.com/Mr0grog/editorconfig-textmate/releases.atom',
          checkpoint: '383f3712d5a3fe4516fcc79350c7572ae00adc28530683993ec7d36e6556206c'
  name 'EditorConfig Plugin for TextMate'
  homepage 'https://github.com/Mr0grog/editorconfig-textmate'

  artifact 'editorconfig-textmate.tmplugin',
           target: "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles/EditorConfig.tmplugin"
end
