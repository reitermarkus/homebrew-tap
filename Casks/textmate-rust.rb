cask 'textmate-rust' do
  version :latest
  sha256 :no_check

  url 'https://github.com/carols10cents/rust.tmbundle/archive/master.tar.gz'
  name 'Rust Plugin for TextMate'
  homepage 'https://github.com/carols10cents/rust.tmbundle'

  plugin_name = 'Rust.tmbundle'

  artifact plugin_name, target: "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles/#{plugin_name}"

  preflight do
    FileUtils.mv staged_path / "#{plugin_name}-master", staged_path / plugin_name
  end
end
