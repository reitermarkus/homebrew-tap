cask "virtualkvm" do
  version "1.2.4"
  sha256 "efe0c3b976464488de7cfdfe2fd55cab0feda4933f7065a025f04e55c515bb72"

  url "https://github.com/duanefields/VirtualKVM/releases/download/v#{version}/v#{version.dots_to_underscores}.zip"
  name "VirtualKVM"
  homepage "https://github.com/duanefields/VirtualKVM"

  app "VirtualKVM.app"
end
