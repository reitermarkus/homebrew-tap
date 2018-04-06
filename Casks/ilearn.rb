cask 'ilearn' do
  version :latest
  sha256 :no_check

  url 'https://github.com/reitermarkus/mirror/raw/master/iLearn.zip' # rubocop:disable Cask/HomepageMatchesUrl
  name 'iLearn'
  homepage 'http://www.rmartijnr.eu/iLearn/index.html'

  app 'iLearn.app'
end
