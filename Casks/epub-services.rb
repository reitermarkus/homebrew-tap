cask :v1 => 'epub-services' do
  version '1.0.1'
  sha256 '2377604b34f42c7c77236805b93ab1ac6badc272e14b7b38832d028aba3da302'

  url "https://github.com/reitermarkus/epub-services/archive/#{version}.tar.gz"
  name 'EPUB Finder Services'
  homepage 'https://github.com/reitermarkus/epub-services'
  license :oss

  depends_on :formula => 'epubcheck'
  depends_on :formula => 'terminal-notifier'

  service "epub-services-#{version}/Check EPUB.workflow"
  service "epub-services-#{version}/Convert to EPUB.workflow"
  service "epub-services-#{version}/Extract EPUB.workflow"

end