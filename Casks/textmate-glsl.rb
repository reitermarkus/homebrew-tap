cask 'textmate-glsl' do
  version :latest
  sha256 :no_check

  url 'https://github.com/reitermarkus/GLSL.tmbundle/archive/master.tar.gz'
  name 'EditorConfig Plugin for TextMate'
  homepage 'https://github.com/reitermarkus/GLSL.tmbundle'

  plugin_name = 'GLSL.tmbundle'

  artifact "#{plugin_name}-master",
           target: "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles/#{plugin_name}"
end
