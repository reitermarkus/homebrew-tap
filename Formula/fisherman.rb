class Fisherman < Formula
  desc "Fish-shell plugin manager"
  homepage "https://fisherman.github.io"

  url "https://github.com/jorgebucaran/fisher/archive/2.13.0.tar.gz"
  sha256 "b91d308e0e10c1fb7afaf3cf427944db98109a3401dea165208b76cc8c9be78e"

  depends_on "fish"

  def install
    fish_function.install "fisher.fish"
    fish_completion.mkpath
    File.write fish_completion/"fisher.fish", "fisher --complete"
  end

  test do
    system "#{Formula["fish"].bin}/fish", "-c", "fisher ls"
  end
end
