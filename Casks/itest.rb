cask 'itest' do
  version :latest
  sha256 :no_check

  url 'http://dl.rmartijnr.eu/iTest/iTest.zip'
  name 'iTest'
  homepage 'http://www.rmartijnr.eu/iTest/index.html'
  license :gratis

  app 'iTest.app'
end
