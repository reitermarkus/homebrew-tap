class Lockscreen < Formula
  desc "Utility to lock your screen."
  homepage "https://github.com/reitermarkus/lockscreen"
  url "https://github.com/reitermarkus/lockscreen/archive/1.0.0.tar.gz"
  sha256 "918e57b662f764ae5a5c98c9b37537ac97471cf46bd30910c71aa67281c925ff"

  def install
    system "make"

    bin.install "lockscreen"
  end
end
