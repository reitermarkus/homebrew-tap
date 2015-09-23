cask :v1 => 'ihelp' do
  version :latest
  sha256 :no_check

  url 'http://dl.rmartijnr.eu/iHelp2/iHelp.zip'
  name 'iHelp'
  homepage 'http://www.rmartijnr.eu/iHelp/index.html'
  license :freemium

  app 'iHelp.app'

  depends_on :macos => '>= :yosemite'
end
