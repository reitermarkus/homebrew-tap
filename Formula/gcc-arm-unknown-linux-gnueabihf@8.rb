class GccArmUnknownLinuxGnueabihfAT8 < Formula
  desc "GNU compiler collection for arm-unknown-linux-gnueabihf"
  homepage "https://github.com/thinkski/osx-arm-linux-toolchains"
  url "https://github.com/thinkski/osx-arm-linux-toolchains/releases/download/8.3.0/arm-unknown-linux-gnueabihf.tar.xz"
  sha256 "5558461f92e806796096b769a89f79d5d21c9d3b87b9bcce12b0079c930f6070"

  conflicts_with "arm-linux-gnueabihf-binutils"

  def install
    rm_f Dir["build.log*"]
    libexec.install Dir["*"]
    libexec.glob("bin/arm-unknown-linux-gnueabihf-*").each do |path|
      bin.install_symlink path
      bin.install_symlink path => path.basename.to_s.sub('arm-unknown-linux-gnueabihf-', 'arm-linux-gnueabihf-')
    end
  end
end
