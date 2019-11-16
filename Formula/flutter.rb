class Flutter < Formula
  desc "Portable UI toolkit for building native applications"
  homepage "https://flutter.dev"
  url "https://github.com/flutter/flutter.git",
    :tag      => "v1.9.1+hotfix.6",
    :revision => "68587a0916366e9512a78df22c44163d041dd5f3"
  version "1.9.1+hotfix.6"

  resource "dart-sdk" do
    url "https://storage.googleapis.com/flutter_infra/flutter/b863200c37df4ed378042de11c4e9ff34e4e58c9/dart-sdk-darwin-x64.zip"
    sha256 "7c38768ec00b1b4207c44105a69cdf7425d947c34f681e2104c7afb839d64157"
  end

  depends_on "libzip"

  def install
    rm Dir["**/*.bat", "**/*.ps1"]
    rm_r Dir["dev", "examples", "packages/*/{examples,test}"]

    # Disable self-upgrade commands.
    inreplace "packages/flutter_tools/lib/executable.dart" do |s|
      s.gsub! "ChannelCommand(verboseHelp: verboseHelp),", ""
      s.gsub! "UpgradeCommand(),", ""
      s.gsub! "VersionCommand(),", ""
    end

    resource("dart-sdk").stage buildpath/"bin/cache/dart-sdk"
    inreplace "bin/flutter" do |s|
      s.gsub! '"$FLUTTER_ROOT/bin/internal/update_dart_sdk.sh"', ""
    end

    touch ".git/refs/tags/.gitkeep"
    touch ".git/refs/heads/.gitkeep"
    touch ".git/objects/info/.gitkeep"

    system "./bin/flutter"

    # Disable automatic self-upgrade.
    inreplace "bin/flutter", "(upgrade_flutter)", "(true)"

    share.install buildpath.children - [buildpath/".brew_home"]

    bin.install_symlink share/"bin/flutter"
  end

  def post_install
    system bin/"flutter", "precache"

    cache_dir = share/"bin/cache"

    chmod_R "+w", cache_dir

    [
      cache_dir/"artifacts/libimobiledevice/idevice_id",
      cache_dir/"artifacts/libimobiledevice/ideviceinfo",
      cache_dir/"artifacts/libimobiledevice/idevicename",
      cache_dir/"artifacts/libimobiledevice/idevicescreenshot",
      cache_dir/"artifacts/libimobiledevice/idevicesyslog",
    ].each do |f|
      MachO::Tools.change_install_name f,
        "/b/s/w/ir/k/homebrew/Cellar/libimobiledevice-flutter/HEAD-398c120_3/lib/libimobiledevice.6.dylib",
        "#{share}/bin/cache/artifacts/libimobiledevice/libimobiledevice.6.dylib"
    end

    MachO::Tools.change_install_name cache_dir/"artifacts/ideviceinstaller/ideviceinstaller",
      "/b/s/w/ir/k/homebrew/opt/libimobiledevice-flutter/lib/libimobiledevice.6.dylib",
      "#{share}/bin/cache/artifacts/libimobiledevice/libimobiledevice.6.dylib"

    [
      cache_dir/"artifacts/ideviceinstaller/ideviceinstaller",
      cache_dir/"artifacts/libimobiledevice/idevice_id",
      cache_dir/"artifacts/libimobiledevice/ideviceinfo",
      cache_dir/"artifacts/libimobiledevice/idevicename",
      cache_dir/"artifacts/libimobiledevice/idevicescreenshot",
      cache_dir/"artifacts/libimobiledevice/idevicesyslog",
      cache_dir/"artifacts/libimobiledevice/libimobiledevice.6.dylib",
      cache_dir/"artifacts/usbmuxd/iproxy",
      cache_dir/"artifacts/usbmuxd/libusbmuxd.4.dylib",
    ].each do |f|
      MachO::Tools.change_install_name f,
        "/b/s/w/ir/k/homebrew/opt/libplist-flutter/lib/libplist.3.dylib",
        "#{share}/bin/cache/artifacts/libplist/libplist.3.dylib"
    end

    MachO::Tools.change_install_name cache_dir/"artifacts/ideviceinstaller/ideviceinstaller",
      "/b/s/w/ir/k/homebrew/opt/libzip-flutter/lib/libzip.5.dylib",
      "#{Formula["libzip"].opt_lib}/libzip.5.dylib"

    [
      cache_dir/"artifacts/libimobiledevice/idevice_id",
      cache_dir/"artifacts/libimobiledevice/ideviceinfo",
      cache_dir/"artifacts/libimobiledevice/idevicename",
      cache_dir/"artifacts/libimobiledevice/idevicescreenshot",
      cache_dir/"artifacts/libimobiledevice/idevicesyslog",
      cache_dir/"artifacts/libimobiledevice/libimobiledevice.6.dylib",
    ].each do |f|
      MachO::Tools.change_install_name f,
        "/b/s/w/ir/k/homebrew/opt/openssl/lib/libcrypto.1.0.0.dylib",
        "#{share}/bin/cache/artifacts/openssl/libcrypto.1.0.0.dylib"

      MachO::Tools.change_install_name f,
        "/b/s/w/ir/k/homebrew/opt/openssl/lib/libssl.1.0.0.dylib",
        "#{share}/bin/cache/artifacts/openssl/libssl.1.0.0.dylib"

      MachO::Tools.change_install_name f,
        "/b/s/w/ir/k/homebrew/opt/usbmuxd-flutter/lib/libusbmuxd.4.dylib",
        "#{share}/bin/cache/artifacts/usbmuxd/libusbmuxd.4.dylib"
    end

    MachO::Tools.change_install_name cache_dir/"artifacts/openssl/libssl.1.0.0.dylib",
      "/b/s/w/ir/k/homebrew/Cellar/openssl-flutter/HEAD-b34cf4e/lib/libcrypto.1.0.0.dylib",
      "#{share}/bin/cache/artifacts/openssl/libcrypto.1.0.0.dylib"

    MachO::Tools.change_install_name cache_dir/"artifacts/usbmuxd/iproxy",
      "/b/s/w/ir/k/homebrew/Cellar/usbmuxd-flutter/HEAD-60109fd_1/lib/libusbmuxd.4.dylib",
      "#{share}/bin/cache/artifacts/usbmuxd/libusbmuxd.4.dylib"
  end

  test do
    system "#{bin}/flutter", "help"
    system "#{bin}/flutter", "--version"
  end
end
