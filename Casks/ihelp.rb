cask 'ihelp' do
  version :latest
  sha256 :no_check

  url 'https://github.com/reitermarkus/mirror/raw/master/iHelp.zip'
  name 'iHelp'
  homepage 'http://www.rmartijnr.eu/iHelp/index.html'

  app 'iHelp.app'
end
