cask 'epub-services' do
  version '1.0.2'
  sha256 '2f8abe0c64c26762d89232ec081d953a02c824d8443fe402c182a9718289446c'

  url "https://github.com/reitermarkus/epub-services/archive/#{version}.tar.gz"
  appcast 'https://github.com/reitermarkus/epub-services/releases.atom',
          checkpoint: 'a64b329e388410639c031b51a9e377334425d41007e14f0a0f3ea5ea17d64f1f'
  name 'EPUB Automator Services'
  homepage 'https://github.com/reitermarkus/epub-services'

  depends_on formula: 'epubcheck'
  depends_on formula: 'terminal-notifier'

  service "epub-services-#{version}/Check EPUB.workflow"
  service "epub-services-#{version}/Convert to EPUB.workflow"
  service "epub-services-#{version}/Extract EPUB.workflow"
end
