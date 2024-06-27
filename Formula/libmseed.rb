class Libmseed < Formula
  desc "Library for the miniSEED data format"
  homepage "https://iris-edu.github.io/libmseed"
  url "https://github.com/iris-edu/libmseed/archive/refs/tags/v3.1.1.tar.gz"
  sha256 "76c4ad6e27c9ded98e63c08647a988d5f18441ca75a81356b52ad3b9b4117acc"
  license "Apache-2.0"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
