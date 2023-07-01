class Dokku < Formula
  desc "Command-line client for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io"
  url "https://github.com/dokku/dokku/archive/v0.28.4.tar.gz"
  sha256 "1403b4bfdf9978298e6714dfeef8b365d495b1913501ea23378c4090b48c7ce4"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end
end
