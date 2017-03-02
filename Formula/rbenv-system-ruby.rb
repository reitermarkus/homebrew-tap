class RbenvSystemRuby < Formula
  desc "plugin to make rbenv compatible with the system Ruby"
  homepage "https://github.com/reitermarkus/rbenv-system-ruby"
  url "https://github.com/reitermarkus/rbenv-system-ruby/archive/1.0.2.tar.gz"
  sha256 "02b05603fb22fc213bcc6c44d2deac8ecd54938a31d08dfdd8ed5e58540854fd"
  head "https://github.com/reitermarkus/rbenv-system-ruby.git"

  bottle :unneeded

  depends_on :rbenv

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_match "system-ruby.bash", shell_output("rbenv hooks exec")
  end
end
