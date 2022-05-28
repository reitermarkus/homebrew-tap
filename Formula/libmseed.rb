class Libmseed < Formula
  desc "Library for the miniSEED data format"
  homepage "https://iris-edu.github.io/libmseed"
  url "https://github.com/iris-edu/libmseed/archive/refs/tags/v2.19.8.tar.gz"
  sha256 "10ac972cb4e76c8d6aa27bf9f56fc59d1922991477d9ddefd375b89dba9e93f6"
  license "Apache-2.0"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
