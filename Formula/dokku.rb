class Dokku < Formula
  desc "Command-line client for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io"
  url "https://github.com/dokku/dokku/archive/refs/tags/v0.38.28.tar.gz"
  sha256 "724042376f7f7738151204c2827a4388dbb4698c4278ecde7334b713dd5cbe55"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end
end
