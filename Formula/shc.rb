class Shc < Formula
  desc "Shell Script Compiler"
  homepage "https://neurobin.github.io/shc"
  url "https://github.com/neurobin/shc/archive/3.9.3a.tar.gz"
  version "3.9.3a"
  sha256 "76b3693cbf9db027e13c9f72d789d8197614ee872e421609a708ddb915bbc9d8"

  head "https://github.com/neurobin/shc.git"

  def install
    system "./configure"
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    (testpath/"test.sh").write <<-EOS.undent
      #!/bin/sh
      exit 0
    EOS
    system "#{bin}/shc", "-f", "test.sh", "-o", "test"
    system "./test"
  end
end
