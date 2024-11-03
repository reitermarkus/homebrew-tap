class Dokku < Formula
  desc "Command-line client for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io"
  url "https://github.com/dokku/dokku/archive/refs/tags/v0.34.6.tar.gz"
  sha256 "57ae9713224e0b413bad18c7a7420ff2b004ce137e85a8e5f3e1156055f30b50"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end
end
