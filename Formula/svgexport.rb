require "language/node"

class Svgexport < Formula
  desc "SVG to PNG/JPEG export tool"
  homepage "https://github.com/shakiba/svgexport"
  url "https://registry.npmjs.org/svgexport/-/svgexport-0.4.2.tgz"
  sha256 "45ef815f0f54890d5f96f9263082138fe41abb99977b06630a56578ca8f49476"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    cp test_fixtures("test.svg"), testpath/"test.svg"
    system bin/"svgexport", testpath/"test.svg", testpath/"test.png"
    assert_predicate testpath/"test.png", :exist?
  end
end
