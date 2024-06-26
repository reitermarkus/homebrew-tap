class AssetcacheExporter < Formula
  desc "Prometheus exporter for AssetCache"
  homepage "https://github.com/reitermarkus/assetcache_exporter"
  url "https://github.com/reitermarkus/assetcache_exporter/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0eab4e7acb96505943c1bcebf4906734163023a81fec99ccbb893b45aee4e4ae"
  head "https://github.com/reitermarkus/assetcache_exporter.git", branch: "main"

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "bundle", "install"
    (libexec/"bin").install "assetcache_exporter.rb"
    (bin/"assetcache_exporter").write_env_script libexec/"bin/assetcache_exporter.rb",
                                                 GEM_HOME: ENV["GEM_HOME"],
                                                 PATH: "#{Formula["ruby"].opt_bin}:$PATH"
  end

  service do
    run opt_bin/"assetcache_exporter"
  end

  test do
    system "true"
  end
end
