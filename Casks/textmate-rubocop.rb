cask 'textmate-rubocop' do
  version :latest
  sha256 :no_check

  url "https://github.com/noniq/RuboCop.tmbundle/archive/master.tar.gz"
  name 'EditorConfig Plugin for TextMate'
  homepage 'https://github.com/reitermarkus/RuboCop.tmbundle'

  plugin_name = 'RuboCop.tmbundle'

  artifact plugin_name, target: "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles/#{plugin_name}"

  preflight do
    FileUtils.mv staged_path/"#{plugin_name}-master", staged_path/plugin_name
  end
end
