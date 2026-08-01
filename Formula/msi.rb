class Msi < Formula
  desc "Print details of data in miniSEED format"
  homepage "https://github.com/EarthScope/msi"
  url "https://github.com/EarthScope/msi/archive/refs/tags/v4.3.0.tar.gz"
  sha256 "3f84b7658bcac99fde4095d1295af48c56d4403fe0c3fc8a8bbf794bf666c466"
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
