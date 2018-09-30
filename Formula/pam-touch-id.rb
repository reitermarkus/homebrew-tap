class PamTouchId < Formula
  desc "PAM module for TouchID"
  homepage "https://github.com/hamzasood/pam_touchid"
  url "https://github.com/hamzasood/pam_touchid/archive/ec7b7bdc1285b3588fe083d5bb9ac5ab5137fda2.tar.gz"
  version "1"
  sha256 "5e8de62996bc2b72a407f241ed9606acd917337e431731e7714995f01fa31723"

  keg_only "it needs to be installed manually as root"

  def install
    xcodebuild "-project", "pam_touchid.xcodeproj", "SYMROOT=build", "-sdk", MacOS.sdk_path

    (bin/"pam_touchid_install").write <<~SH
      #!/bin/sh
      mkdir -p /usr/local/lib/pam
      cp -f #{lib}/pam/pam_touchid.so.2 /usr/local/lib/pam/pam_touchid.so.2
      sudo chmod 444 /usr/local/lib/pam/pam_touchid.so.2
      sudo chown root:wheel /usr/local/lib/pam/pam_touchid.so.2
      sudo sed -i '' '2 i\\
                      auth       sufficient     pam_touchid.so          reason="execute a command as another user"
                     ' /etc/pam.d/sudo
    SH

    (bin/"pam_touchid_uninstall").write <<~SH
      #!/bin/sh
      sudo sed -i '' -E '/^auth +sufficient +pam_touchid.so */d' /etc/pam.d/sudo
      sudo rm -f /usr/local/lib/pam/pam_touchid.so.2
      rmdir /usr/local/lib/pam 2>/dev/null
    SH

    chmod "+x", Dir["bin/*"]

    (lib/"pam").install "build/Release/pam_touchid.so.2"
  end

  def caveats
    <<~EOS
      Use the following scripts to install or uninstall #{name}:

        #{opt_bin}/pam_touchid_install
        #{opt_bin}/pam_touchid_uninstall
    EOS
  end
end
