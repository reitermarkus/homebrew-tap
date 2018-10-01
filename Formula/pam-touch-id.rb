class PamTouchId < Formula
  desc "PAM module for TouchID"
  homepage "https://github.com/reitermarkus/pam-touchID"
  url "https://github.com/reitermarkus/pam-touchID/archive/daacf80cff3e600c9803aa00aa0f9ff1ec5303b8.tar.gz"
  version "2"
  sha256 "704e9bee7dbd91e2416a3cd0169f72e1d610e2388f889a993b36e95e4b2d67d5"

  keg_only "it needs to be installed manually as root"

  def install
    system "make"

    (bin/"pam_touchid_install").write <<~SH
      #!/bin/sh
      "#{bin/"pam_touchid_uninstall"}"
      mkdir -p /usr/local/lib/pam
      cp -f #{lib}/pam/pam_touchid.so /usr/local/lib/pam/pam_touchid.so.#{version}
      sudo chmod 444 /usr/local/lib/pam/pam_touchid.so.#{version}
      sudo chown root:wheel /usr/local/lib/pam/pam_touchid.so.#{version}
      sudo sed -i '' '2 i\\
                      auth       sufficient     pam_touchid.so          reason="execute a command as another user"
                     ' /etc/pam.d/sudo
    SH

    (bin/"pam_touchid_uninstall").write <<~SH
      #!/bin/sh
      sudo sed -i '' -E '/^auth +sufficient +pam_touchid.so */d' /etc/pam.d/sudo
      sudo rm -f /usr/local/lib/pam/pam_touchid.so.#{version}
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
