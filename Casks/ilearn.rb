cask 'ilearn' do
  version :latest
  sha256 :no_check

  url 'http://dl.rmartijnr.eu/iLearn/iLearn.zip'
  name 'iLearn'
  homepage 'http://www.rmartijnr.eu/iLearn/index.html'

  app 'iLearn.app'
end
