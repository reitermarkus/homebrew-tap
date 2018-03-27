cask 'monitorcontrol' do
  version '1.3.0'
  sha256 '93dfcd4ebae31151d2f2e496bf61d5d591fe80ba933d1b03f46763a0a207467d'

  url "https://github.com/the0neyouseek/MonitorControl/releases/download/v#{version}/MonitorControl.dmg"
  appcast 'https://github.com/the0neyouseek/MonitorControl/releases.atom',
          checkpoint: 'dd58f3ed30fb3974b3f15566449dc51d1146c1cf13bd7e9e7cc50727f94e2515'
  name 'MonitorControl'
  homepage 'https://github.com/the0neyouseek/MonitorControl'

  app 'MonitorControl.app'
end
