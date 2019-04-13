cask 'monitorcontrol' do
  version '1.7.0'
  sha256 '47876c98577202cb96fdcd1a9b88897a770ca9af93f904b35d94b087d379d492'

  url "https://github.com/reitermarkus/MonitorControl/releases/download/#{version}/MonitorControl-#{version}.zip"
  appcast 'https://github.com/reitermarkus/MonitorControl/releases.atom'
  name 'MonitorControl'
  homepage 'https://github.com/reitermarkus/MonitorControl'

  app 'MonitorControl.app'
end
