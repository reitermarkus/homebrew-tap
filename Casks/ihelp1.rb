cask 'ihelp1' do
  version :latest
  sha256 :no_check

  url 'http://dl.rmartijnr.eu/iHelp/iHelp.zip'
  name 'iHelp'
  homepage 'http://www.rmartijnr.eu/iHelp/index.html'
  license :freemium

  app 'iHelp.app'
end
