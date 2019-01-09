class PamTouchId < Formula
  desc "PAM module for TouchID"
  homepage "https://github.com/reitermarkus/pam-touchID"
  url "https://github.com/reitermarkus/pam-touchID/archive/7eed8df1ee73f6adf3f9079c65a29a16fe4d22f4.tar.gz"
  version "2"
  sha256 "6eae7c00b0fd96a9b60f96454b1d8dabc2de93484a9b6945c3842b29c94350cd"

  keg_only "it needs to be installed manually as root"

  def install
    system "make"

    (bin/"pam_touchid_install").write <<~SH
      #!/bin/sh
      "#{bin/"pam_touchid_uninstall"}"
      mkdir -p /usr/local/lib/pam
      cp -f #{lib}/pam/pam_touchid.so /usr/local/lib/pam/pam_touchid.so.2
      sudo chmod 444 /usr/local/lib/pam/pam_touchid.so.2
      sudo chown root:wheel /usr/local/lib/pam/pam_touchid.so.2
      sudo sed -i '' '2 i\\
                      auth       sufficient     pam_touchid.so          "reason=execute a command as another user"
                     ' /etc/pam.d/sudo
    SH

    (bin/"pam_touchid_uninstall").write <<~SH
      #!/bin/sh
      sudo sed -i '' -E '/^auth +sufficient +pam_touchid.so */d' /etc/pam.d/sudo
      sudo rm -f /usr/local/lib/pam/pam_touchid.so.2
      rmdir /usr/local/lib/pam 2>/dev/null
    SH

    (lib/"pam").install "pam_touchid.so"
  end

  def caveats
    <<~EOS
      Use the following scripts to install or uninstall #{name}:

        #{opt_bin}/pam_touchid_install
        #{opt_bin}/pam_touchid_uninstall
    EOS
  end
end
