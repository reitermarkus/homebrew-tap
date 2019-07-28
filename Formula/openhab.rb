class Openhab < Formula
  desc "Open Home Automation Bus"
  homepage "https://www.openhab.org/"
  version "2.5.0.M1"
  sha256 "26b5f9ae66b2da3179706c8e2508f2803fa2de090bd57766a37ccc7486b7cf0a"

  bottle :unneeded

  depends_on :java => ["1.8", :optional]

  stable do
    url "https://openhab.jfrog.io/openhab/libs-milestone-local/org/openhab/distro/openhab/2.5.0.M1/openhab-2.5.0.M1.zip"

    resource "addons" do
      url "https://openhab.jfrog.io/openhab/libs-milestone-local/org/openhab/distro/openhab-addons/2.5.0.M1/openhab-addons-2.5.0.M1.kar"
      sha256 "8ddee20968756a81660eaeee84765169d9d4c1bae1cb4f38a3a1c3f5d1dfdc85"
    end

    resource "addons-legacy" do
      url "https://openhab.jfrog.io/openhab/libs-milestone-local/org/openhab/distro/openhab-addons-legacy/2.5.0.M1/openhab-addons-legacy-2.5.0.M1.kar"
      sha256 "c9e205ee02e55f3a8bf7dc1d028874e91a7fcd2f320034e656349dc704354d16"
    end
  end

  head do
    url "https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab/target/openhab-2.5.0-SNAPSHOT.zip"

    resource "addons" do
      url "https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab-addons/target/openhab-addons-2.5.0-SNAPSHOT.kar"
    end

    resource "addons-legacy" do
      url "https://ci.openhab.org/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab-addons-legacy/target/openhab-addons-legacy-2.5.0-SNAPSHOT.kar"
    end
  end

  def install
    rm Dir["**/*.bat", "runtime/update*"]

    resource("addons").stage share/"openhab/addons"
    resource("addons-legacy").stage share/"openhab/addons"

    env = {
      "OPENHAB_CONF"     => "#{etc}/openhab",
      "OPENHAB_RUNTIME"  => "#{share}/openhab/runtime",
      "OPENHAB_USERDATA" => "#{var}/openhab",
      "OPENHAB_LOGDIR"   => "#{var}/openhab/log",
      "OPENHAB_BACKUPS"  => "#{var}/openhab/backups",
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

    (share/"openhab").install "runtime"

    bin.mkpath

    ["client", "start", "stop", "restore", "status"].each do |executable|
      (bin/"openhab-#{executable}").write_env_script("#{share}/openhab/runtime/bin/#{executable}", env)
    end

    libexec.install "start.sh"

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
          <string>#{var}/openhab/log/daemon.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/openhab/log/daemon.log</string>
        </dict>
      </plist>
    EOS
  end
end
