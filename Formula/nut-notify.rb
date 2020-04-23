class NutNotify < Formula
  desc "Terminal-notifier script for NUT"
  homepage "https://github.com/reitermarkus/homebrew-tap"
  url "https://example.org/index.html"
  version "1.0.0"

  depends_on "reattach-to-user-namespace"
  depends_on "terminal-notifier"

  def install
    (prefix/"etc/nut/notify.sh").write <<~EOS
      #!/usr/bin/env bash

      set -euo pipefail

      CURRENT_USER="$(stat -f "%Su" /dev/console)"

      if [[ "${CURRENT_USER}" == root ]]; then
        exit 0
      fi

      case "${NOTIFYTYPE}" in
        ONLINE|COMMOK)
          APP_ICON='/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/GenericNetworkIcon.icns'
          ;;
        SHUTDOWN|FSD)
          APP_ICON='/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns'
          ;;
        *)
          APP_ICON='/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertCautionIcon.icns'
          ;;
      esac

      su "${CURRENT_USER}" -c "'#{Formula["reattach-to-user-namespace"].opt_bin}/reattach-to-user-namespace' '#{Formula["terminal-notifier"].opt_bin}/terminal-notifier' -ignoreDnD -appIcon '${APP_ICON}' -sender com.apple.ActivityMonitor -title 'UPS' -message '${@}'"
    EOS

    chmod "+x", prefix/"etc/nut/notify.sh"
  end
end
