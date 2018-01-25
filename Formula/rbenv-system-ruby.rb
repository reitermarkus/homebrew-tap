class RbenvSystemRuby < Formula
  desc "plugin to make rbenv compatible with the system Ruby"
  homepage "https://github.com/reitermarkus/rbenv-system-ruby"
  url "https://github.com/reitermarkus/rbenv-system-ruby/archive/1.0.4.tar.gz"
  sha256 "0d06ee1ad33b988cba2d27511ab487940bf0c1bf968cd6fd0bffc1b054ca3c01"
  head "https://github.com/reitermarkus/rbenv-system-ruby.git"

  bottle :unneeded

  depends_on "rbenv"

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_match "system-ruby.bash", shell_output("rbenv hooks exec")
    assert_match "system-ruby.bash", shell_output("rbenv hooks rehash")
  end
end
