cask "textmate-opencl" do
  version :latest
  sha256 :no_check

  url "https://github.com/reitermarkus/opencl.tmbundle/archive/master.tar.gz"
  name "OpenCL for TextMate"
  homepage "https://github.com/reitermarkus/opencl.tmbundle"

  artifact "opencl.tmbundle-master",
           target: "#{Dir.home}/Library/Application Support/TextMate/Bundles/OpenCL.tmbundle"
end
