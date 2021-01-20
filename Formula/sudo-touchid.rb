class SudoTouchid < Formula
  desc "Fork of `sudo` with Touch ID support"
  homepage "https://github.com/mattrajca/sudo-touchid"
  head "https://github.com/mattrajca/sudo-touchid.git"

  depends_on xcode: :build
  depends_on macos: :sierra

  def install
    xcodebuild "-project", "sudo.xcodeproj",
               "-target", "sudo",
               "-configuration", "Release",
               "SYMROOT=build"

    bin.install "build/Release/sudo"
  end

  def caveats
    <<-EOS.undent
      To complete the installation of #{name}, run:
        /usr/bin/sudo chown root #{opt_bin}/sudo
        /usr/bin/sudo chmod 4755 #{opt_bin}/sudo
    EOS
  end
end
