class Openhab < Formula
  desc "Open Home Automation Bus"
  homepage "https://www.openhab.org/"
  url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab/2.3.0/openhab-2.3.0.zip"
  sha256 "32bd9a69aa629bfca39134fe7ac1bc5701d8ff66cd18c61f56b3590598946670"

  depends_on :java => "1.8"

  bottle :unneeded

  resource "stable-addons" do
    url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab-addons/2.3.0/openhab-addons-2.3.0.kar"
    sha256 "3e1c92aa7ec1023975ec153509451e90a1fa05cbee3621dab1fb822f0180c50e"
  end

  def install
    rm Dir["**/*.bat", "runtime/update*"]

    # https://github.com/openhab/openhab-distro/pull/758
    inreplace "runtime/bin/oh2_dir_layout", "${OPENHAB_BACKUP}", "${OPENHAB_BACKUPS}"

    inreplace "runtime/bin/setenv", /\. "\$DIRNAME\/oh2_dir_layout"/, <<~EOS
      export OPENHAB_CONF="#{etc}/openhab2"
      export OPENHAB_USERDATA="#{var}/lib/openhab2"
      export OPENHAB_LOGDIR="#{var}/log/openhab2"
      export OPENHAB_BACKUPS="${OPENHAB_USERDATA}/backups"
      \\0
    EOS

    # https://github.com/openhab/openhab-distro/pull/759
    inreplace "runtime/bin/setenv", "/bin/true", "command true"

    File.write "conf/setenv", <<~EOS
      EXTRA_JAVA_OPTS=""
    EOS

    resource("stable-addons").stage share/"openhab2/addons"

    Pathname.new("conf").cd do
      Pathname.glob("**/*").reject(&:directory?).each do |path|
        next if (etc/"openhab2"/path).exist?
        (etc/"openhab2"/path.parent).install path
      end
    end

    Pathname.new("userdata").cd do
      Pathname.glob("**/*").reject(&:directory?).each do |path|
        next if (var/"lib/openhab2"/path).exist?
        (var/"lib/openhab2"/path.parent).install path
      end
    end

    (share/"openhab2").install "runtime"

    bin.mkpath

    ["client", "start", "stop", "restore", "status"].each do |executable|
      (bin/"openhab-#{executable}").write <<~EOS
        #!/bin/sh
        exec "#{share}/openhab2/runtime/bin/#{executable}" "$@"
      EOS
      chmod "+x", bin/"openhab-#{executable}"
    end

    inreplace "start.sh", /DIRNAME=.*/, "DIRNAME=\"#{share}/openhab2\""
    bin.install "start.sh" => "openhab"

    prefix.install_metafiles
  end

  def caveats
    <<~EOS
      To set custom environment variables, put them in
        #{etc}/openhab2/setenv

      If this is your first install, automatically load on startup with:
        sudo cp #{opt_prefix}/#{plist_name}.plist /Library/LaunchDaemons
        sudo launchctl load -w /Library/LaunchDaemons/#{plist_name}.plist

      If this is an upgrade and you already have the plist loaded:
        sudo launchctl unload -w /Library/LaunchDaemons/#{plist_name}.plist
        sudo launchctl load -w /Library/LaunchDaemons/#{plist_name}.plist
    EOS
  end

  plist_options :startup => true, :manual => "openhab"

  def plist_name
    "org.openhab.daemon"
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/openhab</string>
            <string>server</string>
          </array>
          <key>OnDemand</key>
          <false/>
          <key>RunAtLoad</key>
          <true/>
          <key>KeepAlive</key>
          <true/>
          <key>GID</key>
          <integer>20</integer>
          <key>UserName</key>
          <string>root</string>
          <key>StandardErrorPath</key>
          <string>/dev/null</string>
          <key>StandardOutPath</key>
          <string>/dev/null</string>
        </dict>
      </plist>
    EOS
  end
end
