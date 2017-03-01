class RbenvSystemRuby < Formula
  desc "plugin to make rbenv compatible with the system Ruby"
  homepage "https://github.com/reitermarkus/rbenv-system-ruby"
  url "https://github.com/reitermarkus/rbenv-system-ruby/archive/1.0.1.tar.gz"
  sha256 "dbdafa6350b728ecd17fea809eac99df46050508dee4007efac58c7094334405"
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
