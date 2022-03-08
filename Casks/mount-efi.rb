cask "mount-efi" do
  version :latest
  sha256 :no_check

  url "https://github.com/corpnewt/MountEFI/raw/update/Mount%20EFI%20Automator%20Quick%20Action%20Python%203.zip"
  name "Mount EFI"
  homepage "https://github.com/corpnewt/MountEFI"

  service "Mount EFI.workflow"
end
