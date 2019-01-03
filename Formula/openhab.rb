class Openhab < Formula
  desc "Open Home Automation Bus"
  homepage "https://www.openhab.org/"
  url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab/2.4.0/openhab-2.4.0.zip"
  sha256 "abaa07133c4cbd1c2971cb75b64b7eee930abf270e997041b4dccf9366bd89c2"

  depends_on :java => ["1.8", :optional]

  bottle :unneeded

  resource "stable-addons" do
    url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab-addons/2.4.0/openhab-addons-2.4.0.kar"
    sha256 "ccf72a5095fb01b09ea3b30de11465709bbfbc163ca92f48bc6a1d99137390fb"
  end

  def install
    rm Dir["**/*.bat", "runtime/update*"]

    inreplace "runtime/bin/setenv", /\. "\$DIRNAME\/oh2_dir_layout"/, <<~EOS
      export OPENHAB_CONF="#{etc}/openhab2"
      export OPENHAB_USERDATA="#{var}/lib/openhab2"
      export OPENHAB_LOGDIR="#{var}/log/openhab2"
      export OPENHAB_BACKUPS="${OPENHAB_USERDATA}/backups"

      if [ -r "${OPENHAB_CONF}/setenv" ]; then
        . "${OPENHAB_CONF}/setenv"
      fi

      \\0
    EOS

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
          <string>#{var}/log/openhab2/daemon.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/openhab2/daemon.log</string>
        </dict>
      </plist>
    EOS
  end
end
