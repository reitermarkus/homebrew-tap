class Flutter < Formula
  desc "Portable UI toolkit for building native applications"
  homepage "https://flutter.dev"
  url "https://github.com/flutter/flutter.git",
    :tag      => "v1.7.8+hotfix.4",
    :revision => "20e59316b8b8474554b38493b8ca888794b0234a"

  def install
    share.install buildpath.children - [buildpath/".brew_home"]

    bin.write_exec_script "#{share}/bin/flutter"
    chmod "+x", bin/"flutter"

    inreplace share/"packages/flutter_tools/lib/src/dart/sdk.dart",
              "fs.path.join(Cache.flutterRoot, 'bin', 'cache', 'dart-sdk')",
              "'#{libexec}/dart-sdk'"

    # Disable self-upgrade.
    inreplace share/"packages/flutter_tools/lib/executable.dart" do |s|
      s.gsub! "ChannelCommand(verboseHelp: verboseHelp),", ""
      s.gsub! "UpgradeCommand(),", ""
    end

    system bin/"flutter"

    libexec.install share/"bin/cache/dart-sdk"
    libexec.install share/"bin/cache/flutter_tools.snapshot"

    inreplace share/"bin/flutter" do |s|
      s.gsub! "$FLUTTER_ROOT/bin/cache/dart-sdk", "#{libexec}/dart-sdk"
      s.gsub! "$FLUTTER_ROOT/bin/cache/flutter_tools.snapshot", "#{libexec}/flutter_tools.snapshot"
    end

    rm_r share/"bin/cache"
    ln_s var/"flutter/cache", share/"bin/cache"

    # Disable self-upgrade.
    inreplace share/"bin/flutter", "(upgrade_flutter)", "(true)"
  end

  def post_install
    (var/"flutter/cache").mkpath
  end

  test do
    system "#{bin}/flutter", "help"
  end
end
