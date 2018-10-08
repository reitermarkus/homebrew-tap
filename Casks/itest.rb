cask 'itest' do
  version '1.1.0'
  sha256 '4855b94b42b7c6bc9e0c121a75706a5b94199c393017e8a08ec1ceb5a377bc1e'

  url 'https://github.com/reitermarkus/mirror/raw/master/iTest.zip' # rubocop:disable Cask/HomepageMatchesUrl
  name 'iTest'
  homepage 'http://www.rmartijnr.eu/iTest/index.html'

  app 'iTest.app'
end
