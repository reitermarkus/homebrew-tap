class Dokku < Formula
  desc "Command-line client for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io"
  url "https://github.com/dokku/dokku/archive/refs/tags/v0.38.31.tar.gz"
  sha256 "e48cef8635a4e8c5bd614e1e5048267bda465f7ae240613cacaac3e229187c2f"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end
end
