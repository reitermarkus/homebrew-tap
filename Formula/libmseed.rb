class Libmseed < Formula
  desc "Library for the miniSEED data format"
  homepage "https://iris-edu.github.io/libmseed"
  url "https://github.com/iris-edu/libmseed/archive/refs/tags/v2.19.9.tar.gz"
  sha256 "2208d64b784c1aaf21d67c8a7758942ba0e9ba107dc3fc855148ea3af1cbd54b"
  license "Apache-2.0"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
