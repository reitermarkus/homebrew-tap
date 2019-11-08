class Openhab < Formula
  desc "Open Home Automation Bus"
  homepage "https://www.openhab.org/"

  bottle :unneeded

  depends_on "openjdk@11"

  stable do
    url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab/2.4.0/openhab-2.4.0.zip"
    sha256 "abaa07133c4cbd1c2971cb75b64b7eee930abf270e997041b4dccf9366bd89c2"

    resource "addons" do
      url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab-addons/2.4.0/openhab-addons-2.4.0.kar"
      sha256 "ccf72a5095fb01b09ea3b30de11465709bbfbc163ca92f48bc6a1d99137390fb"
    end

    resource "addons-legacy" do
      url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab-addons-legacy/2.4.0/openhab-addons-legacy-2.4.0.kar"
      sha256 "21218e723b04ab82cc674acdb66c3825be24ac3c82cbaad4fa25287ac1b2ff8b"
    end
  end

  devel do
    url "https://openhab.jfrog.io/openhab/libs-milestone-local/org/openhab/distro/openhab/2.5.0.M4/openhab-2.5.0.M4.zip"
    sha256 "e34ce235a9c6212ce6214fcdc00b325dea405ac7625f47ea604135194349bfa4"

    resource "addons" do
      url "https://openhab.jfrog.io/openhab/libs-milestone-local/org/openhab/distro/openhab-addons/2.5.0.M4/openhab-addons-2.5.0.M4.kar"
      sha256 "942577c1f3cb0ab49992607f842d166c88b94cb3ba4daa9f976cda61f2ae96ef"
    end

    resource "addons-legacy" do
      url "https://openhab.jfrog.io/openhab/libs-milestone-local/org/openhab/distro/openhab-addons-legacy/2.5.0.M4/openhab-addons-legacy-2.5.0.M4.kar"
      sha256 "6f7b8a282701b6202963accc26e2045f9c673ea615f17758d42393f540c6e002"
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
    rm Dir["**/*.bat", "**/*.ps1", "**/*.psm1"]
    rm "runtime/bin/update"

    env = {
      "OPENHAB_CONF"     => etc/"openhab",
      "OPENHAB_USERDATA" => var/"openhab",
      "OPENHAB_LOGDIR"   => var/"openhab/log",
      "OPENHAB_BACKUPS"  => var/"openhab/backups",
      "JAVA_HOME"        => Formula["openjdk@11"].opt_libexec/"openjdk.jdk/Contents/Home",
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
