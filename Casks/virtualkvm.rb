cask 'virtualkvm' do
  version '1.1.3'
  sha256 '6e4fccd8640838b7ef372205d6fe812c64ef185b7f53265588cd18471c4c1f0a'

  url "https://github.com/alvaromurillo/VirtualKVM/releases/download/#{version}/VirtualKVM.zip"
  appcast 'https://github.com/alvaromurillo/VirtualKVM/releases.atom',
          checkpoint: '60aab944b2c2637226a543b6b95c20fc3ff1d9ad90ff7f929fcdb93ee33e233f'
  name 'VirtualKVM'
  homepage 'https://github.com/duanefields/VirtualKVM'

  app 'VirtualKVM.app'
end
