cask 'monitorcontrol' do
  version '1.4.1'
  sha256 '5bcbecc055353d1bc1c13c3026697c5699cb0f2942300209e0b973b5be227ec5'

  url "https://github.com/reitermarkus/MonitorControl/releases/download/#{version}/MonitorControl-#{version}.zip"
  appcast 'https://github.com/reitermarkus/MonitorControl/releases.atom'
  name 'MonitorControl'
  homepage 'https://github.com/reitermarkus/MonitorControl'

  app 'MonitorControl.app'
end
