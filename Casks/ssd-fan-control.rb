cask "ssd-fan-control" do
  version "2.13"
  sha256 "38bb039750a81300b732b2e17b3d9fa033b621272d2c50b5322528509f4adc6f"

  url "http://exirion.net/software/SSDFanControl-#{version}.dmg"
  name "SSD Fan Control"
  homepage "http://exirion.net/ssdfanctrl/"

  pkg "SSD Fan Control.pkg"

  uninstall pkgutil: "net.exirion.pkg.SSDFanControl"
end
