class Libmseed < Formula
  desc "Library for the miniSEED data format"
  homepage "https://iris-edu.github.io/libmseed"
  url "https://github.com/iris-edu/libmseed/archive/refs/tags/v3.5.4.tar.gz"
  sha256 "f397b9a32714164d6440b9eeadfbf5b4aece46184515b6ba48941e2cbcb4806a"
  license "Apache-2.0"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
