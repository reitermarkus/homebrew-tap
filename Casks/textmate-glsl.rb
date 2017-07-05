cask 'textmate-glsl' do
  version :latest
  sha256 :no_check

  url 'https://github.com/reitermarkus/GLSL.tmbundle/archive/master.tar.gz'
  name 'EditorConfig Plugin for TextMate'
  homepage 'https://github.com/reitermarkus/GLSL.tmbundle'

  plugin_name = 'GLSL.tmbundle'

  artifact plugin_name, target: "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles/#{plugin_name}"

  preflight do
    FileUtils.mv staged_path.join("#{plugin_name}-master"), staged_path.join(plugin_name)
  end
end
