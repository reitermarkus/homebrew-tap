class Msi < Formula
  desc "Print details of data in miniSEED format"
  homepage "https://github.com/EarthScope/msi"
  url "https://github.com/EarthScope/msi/archive/refs/tags/v3.8.tar.gz"
  sha256 "e1018936832346868307a9934d82083e77894c0e356aab03e0a7e0146bbb6fec"
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
