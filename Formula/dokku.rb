class Dokku < Formula
  desc "Command-line client for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io"
  url "https://github.com/dokku/dokku/archive/v0.26.8.tar.gz"
  sha256 "03bf6712b6f46a2d1b6fb8b93892634f7658c5585d11523985466d3454487d05"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end
end
