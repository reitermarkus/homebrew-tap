cask 'teamspeak-server' do
  version '3.6.0'
  sha256 '64978052be6b32a891bcbbb321f2a489577bb5f75c4c952f3b69e0d0bd1914ff'

  # teamspeak-services.com was verified as official when first introduced to the cask
  url "https://files.teamspeak-services.com/releases/server/#{version}/teamspeak3-server_mac-#{version}.zip"
  appcast 'https://files.teamspeak-services.com/releases/server/'
  name 'TeamSpeak Server'
  homepage 'https://teamspeak.com/'

  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/ts3server.wrapper.sh"
  binary shimscript, target: 'ts3server'

  config_dir = HOMEBREW_PREFIX.join('etc', 'teamspeak-server')

  preflight do
    FileUtils.mkdir_p config_dir

    FileUtils.ln_sf staged_path.join('teamspeak3-server_mac/libts3_ssh.dylib'), config_dir.join('libts3_ssh.dylib')
    FileUtils.ln_sf staged_path.join('teamspeak3-server_mac/libts3db_mariadb.dylib'), config_dir.join('libts3db_mariadb.dylib')
    FileUtils.ln_sf staged_path.join('teamspeak3-server_mac/libts3db_sqlite3.dylib'), config_dir.join('libts3db_sqlite3.dylib')
    FileUtils.ln_sf staged_path.join('teamspeak3-server_mac/redist'), config_dir.join('redist')
    FileUtils.ln_sf staged_path.join('teamspeak3-server_mac/sql'), config_dir.join('sql')

    IO.write shimscript, <<~EOS
      #!/bin/sh

      cd '#{config_dir}' && \
        TS3SERVER_LICENSE=accept exec '#{staged_path}/teamspeak3-server_mac/ts3server' "${@}"
    EOS
  end

  zap trash: config_dir

  caveats do
    <<~EOS
      Configuration files are located in

        #{config_dir}
    EOS
  end
end
