class Tccutil < Formula
  desc "Command Line Tool to add and remove items from the OS X the Accessibility Database (TCC.db)"
  homepage "https://github.com/jacobsalmela/tccutil"
  url "https://github.com/jacobsalmela/tccutil/archive/v1.1.tar.gz"
  sha256 ""
  head "https://github.com/jacobsalmela/tccutil.git"

  bottle :unneeded

  def install
    bin.install "tccutil.py"
  end

  test do
    system "#{bin}/tccutil.py", "--help"
  end
end
