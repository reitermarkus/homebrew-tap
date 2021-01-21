cask "virtualkvm" do
  version "1.2.4"
  sha256 "6e4fccd8640838b7ef372205d6fe812c64ef185b7f53265588cd18471c4c1f0a"

  url "https://github.com/alvaromurillo/VirtualKVM/releases/download/#{version}/VirtualKVM.zip"
  name "VirtualKVM"
  homepage "https://github.com/duanefields/VirtualKVM"

  app "VirtualKVM.app"
end
