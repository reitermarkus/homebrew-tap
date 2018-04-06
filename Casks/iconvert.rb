cask 'iconvert' do
  version :latest
  sha256 :no_check

  url 'https://github.com/reitermarkus/mirror/raw/master/iConvert.zip' # rubocop:disable Cask/HomepageMatchesUrl
  name 'iConvert'
  homepage 'http://www.rmartijnr.eu/iconvert.html'

  app 'iConvert.app'
end
