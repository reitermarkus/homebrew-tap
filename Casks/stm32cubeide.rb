cask "stm32cubeide" do
  version "1.9.0_12015_20220302_0855"
  sha256 "db663b319fae798c39df737d99b6ebc9f0ede665ee68d619964a6b2202303675"

  url "https://www.st.com/content/ccc/resource/technical/software/sw_development_suite/group0/05/31/11/3e/76/1d/40/01/stm32cubeide_mac/files/st-stm32cubeide_#{version}_x86_64.dmg.zip/jcr:content/translations/en.st-stm32cubeide_#{version}_x86_64.dmg.zip"
  name "STM32CubeIDE"
  desc "Integrated Development Environment for STM32"
  homepage "https://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-ides/stm32cubeide.html"

  livecheck do
    skip "Download is walled"
  end

  app "STM32CubeIDE.app"
end
