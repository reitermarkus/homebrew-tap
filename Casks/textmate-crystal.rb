cask 'textmate-crystal' do
  version :latest
  sha256 :no_check

  url 'https://github.com/huacnlee/Crystal.tmbundle/archive/master.tar.gz'
  name 'Crystal Plugin for TextMate'
  homepage 'https://github.com/huacnlee/Crystal.tmbundle'

  plugin_name = 'Crystal.tmbundle'

  artifact plugin_name, target: "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles/#{plugin_name}"

  preflight do
    FileUtils.mv staged_path.join("#{plugin_name}-master"), staged_path.join(plugin_name)
  end
end
