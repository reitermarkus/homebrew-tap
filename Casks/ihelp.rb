cask 'ihelp' do
  version :latest
  sha256 :no_check

  if MacOS.release < :yosemite
    url 'http://dl.rmartijnr.eu/iHelp/iHelp.zip'
  else
    url 'http://dl.rmartijnr.eu/iHelp2/iHelp.zip'
  end

  name 'iHelp'
  homepage 'http://www.rmartijnr.eu/iHelp/index.html'
  license :freemium

  depends_on macos: '>= :yosemite'

  app 'iHelp.app'
end
