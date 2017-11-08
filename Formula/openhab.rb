class Openhab < Formula
  desc "Open Home Automation Bus"
  homepage "http://www.openhab.org/"

  url "https://bintray.com/openhab/mvn/download_file?file_path=org/openhab/distro/openhab/2.1.0/openhab-2.1.0.zip"
  sha256 "d610b30dff353b3c5b3521b8a0f26ca5799803e762841ad9b17e9b2c8d53d1f4"

  depends_on :java

  def install
    inreplace "runtime/bin/oh2_dir_layout" do |s|
      s.gsub! "${OPENHAB_HOME}/conf", etc/"openhab"
      s.gsub! "${OPENHAB_HOME}/userdata", var/"openhab"
      s.gsub! "${OPENHAB_USERDATA}/logs", "${OPENHAB_USERDATA}/log"

      s.sub! /\n*\Z/, "\n\n[ -f '#{etc}/openhab/setenv' ] && . '#{etc}/openhab/setenv'\n"
    end

    inreplace "start.sh", /DIRNAME=.*/, "DIRNAME=\"#{opt_prefix}\""
    bin.install "start.sh" => "openhab"

    rm "start_debug.sh"
    rm Dir.glob("**/*.bat")

    Pathname.new("conf/setenv").write "EXTRA_JAVA_OPTS=\"\"\n"
    Pathname.new("conf").cd do
      Pathname.glob("**/*").reject(&:directory?).each do |file|
        next if (etc/"openhab"/file).exist?
        (etc/"openhab"/file.parent).mkpath
        (etc/"openhab"/file.parent).install file
      end
    end
    rm_r "conf"

    Pathname.new("userdata").cd do
      Pathname.glob("**/*").reject(&:directory?).each do |file|
        next if (var/"openhab"/file).exist?
        (var/"openhab"/file.parent).mkpath
        (var/"openhab"/file.parent).install file
      end
    end
    rm_r "userdata"

    (bin/"openhab-console").write <<-EOS.undent
      #!/bin/sh
      exec "#{prefix}/runtime/bin/client" "$@"
    EOS

    prefix.install Dir.glob("*")
  end

  def caveats
    <<-EOS.undent
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

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>Program</key>
        <string>#{opt_bin}/openhab</string>
        <key>OnDemand</key>
        <false/>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>GID</key>
        <integer>501</integer>
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

  test do
    true
  end
end
