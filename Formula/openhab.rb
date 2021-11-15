class Openhab < Formula
  desc "Open Home Automation Bus"
  homepage "https://www.openhab.org/"

  stable do
    url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab/2.5.1/openhab-2.5.1.zip"
    sha256 "38541e39b06b37e801e98748a1b8dbce3574be49867d9314c64dbdb818ca8008"

    resource "addons" do
      url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab-addons/2.5.1/openhab-addons-2.5.1.kar"
      sha256 "2d61a4d2506c686c8cf16e71dad3ffc76a8e6018d83696628868e0419c4f9f50"
    end

    resource "addons-legacy" do
      url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab-addons-legacy/2.5.1/openhab-addons-legacy-2.5.1.kar"
      sha256 "2371af339e76827d040e5a877a6ebcb89aad0cb4ed7c4113cb03ba924e999768"
    end
  end

  head do
    url "https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab/target/openhab-2.5.2-SNAPSHOT.zip"

    resource "addons" do
      url "https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab-addons/target/openhab-addons-2.5.2-SNAPSHOT.kar"
    end

    resource "addons-legacy" do
      url "https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab-addons-legacy/target/openhab-addons-legacy-2.5.2-SNAPSHOT.kar"
    end
  end

  depends_on "openjdk@11"

  def install
    rm Dir["**/*.bat", "**/*.ps1", "**/*.psm1"]
    rm "runtime/bin/update"

    env = {
      "OPENHAB_CONF"     => etc/"openhab",
      "OPENHAB_USERDATA" => var/"openhab",
      "OPENHAB_LOGDIR"   => var/"openhab/log",
      "OPENHAB_BACKUPS"  => var/"openhab/backups",
      "JAVA_HOME"        => Formula["openjdk@11"].opt_prefix,
    }

    inreplace "runtime/bin/setenv", %r{\. "\$DIRNAME/oh2_dir_layout"}, <<~EOS
      if [ -f "${OPENHAB_CONF}/setenv" ]; then
        . "${OPENHAB_CONF}/setenv"
      fi

      \\0
    EOS

    Pathname.new("conf").cd do
      Pathname.glob("**/*").reject(&:directory?).each do |path|
        next if (etc/"openhab"/path).exist?

        (etc/"openhab"/path.parent).install path
      end
    end

    Pathname.new("userdata").cd do
      Pathname.glob("**/*").reject(&:directory?).each do |path|
        next if (var/"openhab"/path).exist?

        (var/"openhab"/path.parent).install path
      end
    end

    resource("addons").stage libexec/"addons"
    resource("addons-legacy").stage libexec/"addons"
    libexec.install "runtime"
    libexec.install "start.sh"

    bin.mkpath

    %w[client start stop restore status].each do |executable|
      (bin/"openhab-#{executable}").write_env_script("#{libexec}/runtime/bin/#{executable}", env)
    end

    (bin/"openhab").write_env_script(libexec/"start.sh", env)

    prefix.install_metafiles
  end

  def caveats
    <<~EOS
      To set custom environment variables, put them in
        #{etc}/openhab/setenv

      If this is your first install, automatically load on startup with:
        sudo cp #{opt_prefix}/#{plist_name}.plist /Library/LaunchDaemons
        sudo launchctl load -w /Library/LaunchDaemons/#{plist_name}.plist

      If this is an upgrade and you already have the plist loaded:
        sudo launchctl unload -w /Library/LaunchDaemons/#{plist_name}.plist
        sudo launchctl load -w /Library/LaunchDaemons/#{plist_name}.plist
    EOS
  end

  plist_options startup: true, manual: "openhab"

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
          <string>#{var}/openhab/log/daemon.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/openhab/log/daemon.log</string>
        </dict>
      </plist>
    EOS
  end
end
