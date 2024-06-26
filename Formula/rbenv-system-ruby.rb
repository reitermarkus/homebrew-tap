class RbenvSystemRuby < Formula
  desc "Plugin to make rbenv compatible with the system Ruby"
  homepage "https://github.com/reitermarkus/rbenv-system-ruby"
  url "https://github.com/reitermarkus/rbenv-system-ruby/archive/refs/tags/1.0.4.tar.gz"
  sha256 "0d06ee1ad33b988cba2d27511ab487940bf0c1bf968cd6fd0bffc1b054ca3c01"
  head "https://github.com/reitermarkus/rbenv-system-ruby.git"

  depends_on "rbenv"

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_match "system-ruby.bash", shell_output("rbenv hooks exec")
    assert_match "system-ruby.bash", shell_output("rbenv hooks rehash")
  end
end
