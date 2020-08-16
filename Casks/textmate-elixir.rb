cask "textmate-elixir" do
  version :latest
  sha256 :no_check

  url "https://github.com/elixir-lang/elixir-tmbundle/archive/master.tar.gz"
  name "Crystal Plugin for TextMate"
  homepage "https://github.com/elixir-lang/elixir-tmbundle"

  artifact "elixir-tmbundle-master",
           target: "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles/Elixir.tmbundle"
end
