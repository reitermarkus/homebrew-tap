cask 'monitorcontrol' do
  version '1.5.0'
  sha256 '0da9a1e9df8b4f88d6dffb4a3763325939e15021e5b2d8a9110d1d7be3a456ec'

  url "https://github.com/reitermarkus/MonitorControl/releases/download/#{version}/MonitorControl-#{version}.zip"
  appcast 'https://github.com/reitermarkus/MonitorControl/releases.atom'
  name 'MonitorControl'
  homepage 'https://github.com/reitermarkus/MonitorControl'

  app 'MonitorControl.app'
end
