cask :v1 => 'epub-services' do
  version '1.0.0'
  sha256 '23dd6316eeebb250ff11581a263180326540fe58dda558d448587270998b768d'

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