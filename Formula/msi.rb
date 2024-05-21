class Msi < Formula
  desc "Print details of data in miniSEED format"
  homepage "https://github.com/EarthScope/msi"
  url "https://github.com/EarthScope/msi/archive/refs/tags/v4.2.tar.gz"
  sha256 "c966fefe0aae0bdc5b61522b18f800458044a36d62da38cd5d566a343c7a1846"
  license "GPL-3.0"

  depends_on "libmseed"

  def install
    rm_r "libmseed"

    cd "src" do
      inreplace "Makefile" do |s|
        s.gsub! "-I../libmseed", ""
        s.gsub! "-L../libmseed", ""
      end

      system "make"
    end

    bin.install "msi"
  end

  test do
    system "#{bin}/msi", "-h"
  end
end
