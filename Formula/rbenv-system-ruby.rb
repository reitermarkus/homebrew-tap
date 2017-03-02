class RbenvSystemRuby < Formula
  desc "plugin to make rbenv compatible with the system Ruby"
  homepage "https://github.com/reitermarkus/rbenv-system-ruby"
  url "https://github.com/reitermarkus/rbenv-system-ruby/archive/1.0.3.tar.gz"
  sha256 "632eea4f7c16e93e776a9d8502ca39283669a2036e593cf6bc6e6cdbacb00fee"
  head "https://github.com/reitermarkus/rbenv-system-ruby.git"

  bottle :unneeded

  depends_on :rbenv

  def install
    prefix.install Dir["*"]
  end

  test do
    assert_match "system-ruby.bash", shell_output("rbenv hooks exec")
    assert_match "system-ruby.bash", shell_output("rbenv hooks rehash")
  end
end
