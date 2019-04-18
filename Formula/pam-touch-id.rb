class PamTouchId < Formula
  desc "PAM module for TouchID"
  homepage "https://github.com/Reflejo/pam-touchID"
  url "https://github.com/reitermarkus/pam-touchID/archive/e918e3ad9b954a4b7b9ffd1d30999dee068fc9c6.tar.gz"
  version "2"
  sha256 "fd9c56739368cb029cce3576d87bcf5a286a1b3c2fcedfc9161973eda6363d04"

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
