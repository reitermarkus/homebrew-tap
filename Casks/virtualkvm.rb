cask "virtualkvm" do
  version "1.2.4"
  sha256 "6e4fccd8640838b7ef372205d6fe812c64ef185b7f53265588cd18471c4c1f0a"

  url "https://github.com/duanefields/VirtualKVM/releases/download/v#{version}/v#{version.dots_to_underscores}.zip"
  name "VirtualKVM"
  homepage "https://github.com/duanefields/VirtualKVM"

  app "VirtualKVM.app"
end
