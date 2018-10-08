cask 'hardware-io-tools-for-xcode' do
  version '7.3'
  sha256 '2bf64b4ec9c3b5a44690c750b36f2267da774aac76b72aa19ca90d3625b409bd'

  url do
    cookies = {
                'ADCDownloadAuth' => URI.decode_www_form_component(ENV.fetch('HOMEBREW_ADC_DOWNLOAD_AUTH')),
              }

    [
      'https://download.developer.apple.com/Developer_Tools/Hardware_IO_Tools_for_Xcode_7.3/Hardware_IO_Tools_for_Xcode_7.3.dmg',
      { cookies: cookies },
    ]
  end
  name 'Hardware IO Tools for Xcode 7.3'
  homepage 'https://developer.apple.com/download/more/?name=Hardware%20IO%20Tools%20for%20Xcode%207.3'

  app 'Bluetooth Explorer.app'
  app 'HomeKit Accessory Simulator.app'
  app 'IORegistryExplorer.app'
  app 'PacketLogger.app'
  app 'Printer Simulator.app'
  prefpane 'Network Link Conditioner.prefPane'
end
