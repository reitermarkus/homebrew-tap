cask 'hardware-io-tools-for-xcode' do
  version '7.3'
  sha256 '2bf64b4ec9c3b5a44690c750b36f2267da774aac76b72aa19ca90d3625b409bd'

  url 'https://download.developer.apple.com/Developer_Tools/Hardware_IO_Tools_for_Xcode_7.3/Hardware_IO_Tools_for_Xcode_7.3.dmg',
      cookies: {
                 'ADCDownloadAuth' => 'oqIqKigeZ30QuoHSZlbxS9kGyR+UEeIxw4JgvtBQhayCRzk/v1aQW2+ZTj4Pu3bg2ilfluGGsciZA9moZMVJ+eP1RRBNytER4nbKPEmp4qiGGLjh1PT7bkTWY5x2NBOvglE1h+j1trOffY2cRN6CVnGQXFjFfNzs4hfZvgRlcXUDRs+s',
               }
  name 'Hardware IO Tools for Xcode 7.3'
  homepage 'https://developer.apple.com/download/more/?name=Hardware%20IO%20Tools%20for%20Xcode%207.3'

  app 'Bluetooth Explorer.app'
  app 'HomeKit Accessory Simulator.app'
  app 'IORegistryExplorer.app'
  app 'PacketLogger.app'
  app 'Printer Simulator.app'
  prefpane 'Network Link Conditioner.prefPane'
end
