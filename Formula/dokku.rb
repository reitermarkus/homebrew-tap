class Dokku < Formula
  desc "Command-line client for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io"
  url "https://github.com/dokku/dokku/archive/refs/tags/v0.34.5.tar.gz"
  sha256 "33ca8c8505b8ef2b4e9f61da90983c59625512cee1dfb852ee3ba8f2af8e2a2f"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end
end
