cask :v1 => 'ilearn' do
  version :latest
  sha256 :no_check

  url 'http://dl.rmartijnr.eu/iLearn/iLearn.zip'
  name 'iLearn'
  homepage 'http://www.rmartijnr.eu/iLearn/index.html'
  license :freemium

  app 'iLearn.app'
end
