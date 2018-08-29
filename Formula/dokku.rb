class Dokku < Formula
  desc "Command-line client for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io"
  url "https://github.com/dokku/dokku/archive/v0.12.12.tar.gz"
  sha256 "40137e1abdf7ccf78be5cf00d9800b10992f660c1a56bbed086ae2085037ad78"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end
end
