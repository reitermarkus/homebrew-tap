cask 'textmate-onsave' do
  version :latest
  sha256 :no_check

  url 'https://github.com/reitermarkus/on-save.tmbundle/archive/master.tar.gz'
  name 'OnSave for TextMate'
  homepage 'https://github.com/reitermarkus/on-save.tmbundle'

  artifact 'on-save.tmbundle-master',
           target: "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles/OnSave.tmbundle"
end
