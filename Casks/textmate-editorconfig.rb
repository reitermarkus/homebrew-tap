cask 'textmate-editorconfig' do
  version '0.4.0'
  sha256 'fd6b4aca1d0b044dcd366f0459f3da0d82a793ed2b9e956cd6b969b1f42ed451'

  url "https://github.com/Mr0grog/editorconfig-textmate/releases/download/v#{version}/editorconfig-textmate-#{version}.tmplugin.zip"
  appcast 'https://github.com/Mr0grog/editorconfig-textmate/releases.atom',
          checkpoint: '383f3712d5a3fe4516fcc79350c7572ae00adc28530683993ec7d36e6556206c'
  name 'EditorConfig Plugin for TextMate'
  homepage 'https://github.com/Mr0grog/editorconfig-textmate'

  artifact 'editorconfig-textmate.tmplugin',
           target: "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles/EditorConfig.tmplugin"
end
