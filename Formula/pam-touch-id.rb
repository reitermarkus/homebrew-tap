class PamTouchId < Formula
  desc "PAM module for TouchID"
  homepage "https://github.com/Reflejo"
  url "https://github.com/Reflejo/pam-touchID/archive/2ba19224e6f5a3679cec4cf3983804417b9c44ee.tar.gz"
  version "2"
  sha256 "3f441565ded432f2af4e205e23bb3f000d6dcf79cb971917bbf49de2c6eca28a"

  keg_only "Needs to be installed manually as root."

  def install
    inreplace "Makefile", "/usr/local", prefix
    inreplace "Makefile", /chown root:wheel.*/, ""
    system "make", "install"
  end
end
