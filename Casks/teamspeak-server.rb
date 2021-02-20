cask "teamspeak-server" do
  version "3.13.3"
  sha256 "6731a723737b0662aec9127710399f32d1bdcdffc1c33a419404cf6a54fa3ee7"

  url "https://files.teamspeak-services.com/releases/server/#{version}/teamspeak3-server_mac-#{version}.zip",
      verified: "teamspeak-services.com"
  name "TeamSpeak Server"
  homepage "https://teamspeak.com/"

  livecheck do
    url "https://files.teamspeak-services.com/releases/server/"
    strategy :page_match
    regex(/href="?(\d+(?:\.\d+)*)/)
  end

  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/ts3server.wrapper.sh"
  binary shimscript, target: "ts3server"

  config_dir = HOMEBREW_PREFIX.join("etc", "teamspeak-server")

  preflight do
    FileUtils.mkdir_p config_dir

    FileUtils.ln_sf staged_path.join("teamspeak3-server_mac/libts3_ssh.dylib"),
                    config_dir.join("libts3_ssh.dylib")
    FileUtils.ln_sf staged_path.join("teamspeak3-server_mac/libts3db_mariadb.dylib"),
                    config_dir.join("libts3db_mariadb.dylib")
    FileUtils.ln_sf staged_path.join("teamspeak3-server_mac/libts3db_sqlite3.dylib"),
                    config_dir.join("libts3db_sqlite3.dylib")
    FileUtils.ln_sf staged_path.join("teamspeak3-server_mac/redist"),
                    config_dir.join("redist")
    FileUtils.ln_sf staged_path.join("teamspeak3-server_mac/sql"),
                    config_dir.join("sql")

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
