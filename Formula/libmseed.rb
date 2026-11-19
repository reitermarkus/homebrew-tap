class Libmseed < Formula
  desc "Library for the miniSEED data format"
  homepage "https://iris-edu.github.io/libmseed"
  url "https://github.com/iris-edu/libmseed/archive/refs/tags/v3.6.0.tar.gz"
  sha256 "5cdec12523d3df42a61c8a7260c0e66e5e1dcd1954af16706601448adf8d6e55"
  license "Apache-2.0"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
