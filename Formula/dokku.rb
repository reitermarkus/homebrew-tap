class Dokku < Formula
  desc "Command-line client for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io"
  url "https://github.com/dokku/dokku/archive/refs/tags/v0.38.27.tar.gz"
  sha256 "a386e294f45899c03b2c56e17562a41db5268522078dbc12702215bf1ce15a5a"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end
end
