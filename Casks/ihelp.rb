cask 'ihelp' do
  version :latest
  sha256 :no_check

  if MacOS.version <= :mavericks
    url 'http://dl.rmartijnr.eu/iHelp/iHelp.zip'
  else
    url 'http://dl.rmartijnr.eu/iHelp2/iHelp.zip'
  end

  name 'iHelp'
  homepage 'http://www.rmartijnr.eu/iHelp/index.html'

  app 'iHelp.app'
end
