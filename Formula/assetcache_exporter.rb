class AssetcacheExporter < Formula
  desc "Prometheus exporter for AssetCache"
  homepage "https://github.com/reitermarkus/assetcache_exporter"
  head "https://github.com/reitermarkus/assetcache_exporter.git", branch: "main"

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "bundle", "install"
    (libexec/"bin").install "assetcache_exporter.rb"
    (bin/"assetcache_exporter").write_env_script libexec/"bin/assetcache_exporter.rb",
                                                 GEM_HOME: ENV["GEM_HOME"]
  end

  service do
    run opt_bin/"assetcache_exporter"
  end

  test do
    system "true"
  end
end
