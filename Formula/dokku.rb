class Dokku < Formula
  desc "Command-line client for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io"
  url "https://github.com/dokku/dokku/archive/refs/tags/v0.38.34.tar.gz"
  sha256 "13893a119c18896b9ab2dad39311ec6b11d1b5c37ae0efc93f7ef61d367e2575"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end
end
