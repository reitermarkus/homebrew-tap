class Flutter < Formula
  desc "Portable UI toolkit for building native applications"
  homepage "https://flutter.dev"
  url "https://github.com/flutter/flutter.git",
    :tag      => "v1.7.8+hotfix.3",
    :revision => "b712a172f9694745f50505c93340883493b505e5"

  def install
    libexec.install buildpath.children - [buildpath/".brew_home"]
    inreplace libexec/"packages/flutter_tools/lib/executable.dart", "UpgradeCommand(),", ""
    bin.write_exec_script "#{libexec}/bin/flutter"

    # Install dependencies and disable self-upgrade afterwards.
    chmod "+x", bin/"flutter"
    system bin/"flutter", "precache"
    inreplace libexec/"bin/flutter", "(upgrade_flutter)", "(true)"
  end

  test do
    system "#{bin}/flutter", "help"
  end
end
