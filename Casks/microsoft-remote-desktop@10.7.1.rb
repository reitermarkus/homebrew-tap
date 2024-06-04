cask "microsoft-remote-desktop@10.7.1" do
  version "10.7.1"
  sha256 "504a2f9a85ffccc2b145e1102f77d25985534271aa4106f150cb0b72f06b42f5"

  url "https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_Remote_Desktop_#{version}_installer.pkg",
      verified: "officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/"
  name "Microsoft Remote Desktop"
  desc "Remote desktop client"
  homepage "https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac"

  livecheck do
    url "https://go.microsoft.com/fwlink/?linkid=868963"
    strategy :header_match
  end

  auto_updates true
  depends_on macos: ">= :high_sierra"
  container type: :naked

  app "Microsoft_Remote_Desktop_#{version}_installer/com.microsoft.rdc.macos.pkg/Payload/Microsoft Remote Desktop.app",
      target: "Microsoft Remote Desktop #{version}.app"

  preflight do
    system_command "pkgutil", args: ["--expand-full", "#{staged_path}/Microsoft_Remote_Desktop_#{version}_installer.pkg", "#{staged_path}/Microsoft_Remote_Desktop_#{version}_installer"]
  end

  postflight do
    system_command "defaults", args: [
      "write", "com.microsoft.rdc.macos", "ClientSettings.DisableOnPremWebSocketGateway", "true"
    ]
  end

  zap trash: [
    "~/Library/Application Scripts/com.microsoft.rdc.macos",
    "~/Library/Containers/com.microsoft.rdc.macos",
    "~/Library/Group Containers/UBF8T346G9.com.microsoft.rdc",
  ]
end
