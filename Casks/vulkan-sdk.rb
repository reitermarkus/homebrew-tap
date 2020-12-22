cask "vulkan-sdk" do
  version "1.2.162.0"
  sha256 "d5d25d801eb83130db1e41fa6c09f125ba57e7503ae81553182ba7196f32a0a3"

  url "https://sdk.lunarg.com/sdk/download/#{version}/mac/vulkansdk-macos-#{version}.dmg"
  name "Vulkan SDK"
  desc "Development kit"
  homepage "https://vulkan.lunarg.com/sdk/home"

  livecheck do
    url "https://vulkan.lunarg.com/sdk/latest/mac.txt"
    regex(/(\d+(?:\.\d+)*)/i)
  end

  conflicts_with formula: "vulkan-headers"

  installer script: {
    executable: "bash",
    args:       ["-c", "cd '#{staged_path}' && ./install_vulkan.py --force-install"],
  }

  postflight do
    set_permissions "#{staged_path}/uninstall.sh", "+x"
  end

  uninstall script: {
    executable: "#{staged_path}/uninstall.sh",
  }

  caveats do
    files_in_usr_local
  end
end
