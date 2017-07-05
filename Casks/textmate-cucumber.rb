cask 'textmate-cucumber' do
  version :latest
  sha256 :no_check

  url 'https://github.com/cucumber/cucumber-tmbundle/archive/master.tar.gz'
  name 'Crystal Plugin for TextMate'
  homepage 'https://github.com/cucumber/cucumber-tmbundle'

  plugin_name = 'Cucumber.tmbundle'

  artifact plugin_name, target: "#{ENV['HOME']}/Library/Application Support/TextMate/Bundles/#{plugin_name}"

  preflight do
    FileUtils.mv staged_path.join("cucumber-tmbundle-master"), staged_path.join(plugin_name)
  end
end
