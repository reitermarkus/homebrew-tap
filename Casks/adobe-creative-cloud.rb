cask 'adobe-creative-cloud' do
  version :latest
  sha256 :no_check

  url 'https://ccmdls.adobe.com/AdobeProducts/KCCC/1/osx10/CreativeCloudInstaller.dmg'
  name 'Adobe Creative Cloud'
  homepage 'https://creative.adobe.com/products/creative-cloud'
  license :commercial

  installer :script => 'Creative Cloud Installer.app/Contents/MacOS/Install'

  uninstall :script => '/Applications/Utilities/Adobe Creative Cloud/Utils/Creative Cloud Uninstaller.app/Contents/MacOS/Creative Cloud Uninstaller'

end
