cask "sheepshaver" do
  version "2.4.20140201"
  sha256 "545bcd5348c5ce88d18f3f0f01971107472208d1c84361d94c8ce2c238212788"

  url "http://www.xs4all.nl/~ronaldpr/sheepshaverforum/SheepShaver_UB_#{version.patch}.zip",
      verified: "www.xs4all.nl/~ronaldpr/sheepshaverforum/"
  name "SheepShaver"
  homepage "http://sheepshaver.cebix.net/"

  app "SheepShaver_UB_#{version.patch}/SheepShaver.app"
end
