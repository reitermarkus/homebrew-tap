cask :v1 => 'iconvert' do
  version :latest
  sha256 :no_check

  url 'http://dl.rmartijnr.eu/iConvert/iConvert.zip'
  name 'iConvert'
  homepage 'http://www.rmartijnr.eu/iConvert/index.html'
  license :gratis

  app 'iConvert.app'
end
