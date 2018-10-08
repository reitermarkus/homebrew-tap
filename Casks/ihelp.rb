cask 'ihelp' do
  version '2.0.1'
  sha256 'edd62863a31c61fc8cfb7c5507dd41ba69118af872e620fb23472b4f4f2f1e2e'

  url 'https://github.com/reitermarkus/mirror/raw/master/iHelp.zip' # rubocop:disable Cask/HomepageMatchesUrl
  name 'iHelp'
  homepage 'http://www.rmartijnr.eu/iHelp/index.html'

  app 'iHelp.app'
end
