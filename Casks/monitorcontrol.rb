cask 'monitorcontrol' do
  version '1.6.0'
  sha256 '167d66e59de44d5014a1fec4d2b6b9ef79cf9a963615a1107000d41e33c102ac'

  url "https://github.com/reitermarkus/MonitorControl/releases/download/#{version}/MonitorControl-#{version}.zip"
  appcast 'https://github.com/reitermarkus/MonitorControl/releases.atom'
  name 'MonitorControl'
  homepage 'https://github.com/reitermarkus/MonitorControl'

  app 'MonitorControl.app'
end
