cask 'monitorcontrol' do
  version '1.4.0'
  sha256 '4f806952e4048c2152de9b1cee5880767f573fb400e28346e320b541816fb1de'

  url "https://github.com/reitermarkus/MonitorControl/releases/download/#{version}/MonitorControl-#{version}.zip"
  appcast 'https://github.com/reitermarkus/MonitorControl/releases.atom'
  name 'MonitorControl'
  homepage 'https://github.com/reitermarkus/MonitorControl'

  app 'MonitorControl.app'
end
