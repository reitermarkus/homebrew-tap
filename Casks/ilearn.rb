cask 'ilearn' do
  version :latest
  sha256 :no_check

  url 'https://github.com/reitermarkus/mirror/raw/master/iLearn.zip'
  name 'iLearn'
  homepage 'http://www.rmartijnr.eu/iLearn/index.html'

  app 'iLearn.app'
end
