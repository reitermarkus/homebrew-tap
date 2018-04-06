cask 'itest' do
  version :latest
  sha256 :no_check

  url 'https://github.com/reitermarkus/mirror/raw/master/iTest.zip' # rubocop:disable Cask/HomepageMatchesUrl
  name 'iTest'
  homepage 'http://www.rmartijnr.eu/iTest/index.html'

  app 'iTest.app'
end
