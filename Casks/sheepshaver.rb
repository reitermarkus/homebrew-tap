cask "sheepshaver" do
  version "2.5.20240228"
  sha256 "07628738b0f62f5f61e7f3312b75b33e421db981674e1fd17b53aee9757edc93"

  url "https://www.emaculation.com/sheepshaver/SheepShaver_universal_#{version.patch}.zip",
      verified: "emaculation.com/sheepshaver/"
  name "SheepShaver"
  homepage "http://sheepshaver.cebix.net/"

  livecheck do
    url "https://www.emaculation.com/forum/viewtopic.php?t=7360"
    regex(/Version:?\s*(\d+\.\d+).*SheepShaver[._-]?(?:universal[._-]?)?(\d{4})(\d{2})(\d{2})\.zip/)
  end

  app "SheepShaver_UB_#{version.patch}/SheepShaver.app"
end
