cask 'monitorcontrol' do
  version '1.8.0'
  sha256 '6eab7860dffcccd8f66acda74b3be8cffa64599a5db7ec2350ee1be310237e6a'

  url "https://github.com/reitermarkus/MonitorControl/releases/download/#{version}/MonitorControl-#{version}.zip"
  appcast 'https://github.com/reitermarkus/MonitorControl/releases.atom'
  name 'MonitorControl'
  homepage 'https://github.com/reitermarkus/MonitorControl'

  app 'MonitorControl.app'
end
