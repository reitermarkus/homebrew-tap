class Fisher < Formula
  desc "Plugin manager for the Fish shell"
  homepage "https://github.com/jorgebucaran/fisher"

  url "https://github.com/jorgebucaran/fisher/archive/3.2.10.tar.gz"
  sha256 "63827f63bd998b9b66e47d934cf21e3211f8fbd285abc7e9fbc8fc203655c23c"

  bottle :unneeded

  depends_on "fish"

  def install
    inreplace "fisher.fish" do |s|
      s.gsub! "case self-update", "case self-update-disabled"
      s.gsub! "case self-uninstall", "case self-uninstall-disabled"
      s.gsub! "$fisher_path/completions/fisher.fish", "#{fish_completion}/fisher.fish"
    end

    fish_function.install "fisher.fish"
    (fish_completion/"fisher.fish").write "fisher complete\n"
  end

  test do
    system "#{Formula["fish"].bin}/fish", "-c", "fisher add jethrokuan/z"
    assert_equal File.read(testpath/".config/fish/fishfile"), "jethrokuan/z\n"
  end
end
