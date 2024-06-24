class NutNotify < Formula
  desc "Terminal-notifier script for NUT"
  homepage "https://github.com/reitermarkus/homebrew-tap"
  url "https://example.org/index.html"
  version "1.0.0"
  sha256 "ea8fac7c65fb589b0d53560f5251f74f9e9b243478dcb6b3ea79b5e36449c8d9"

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
          SENDER='com.apple.AVB-Audio-Configuration'
          ;;
        SHUTDOWN|FSD)
          APP_ICON='/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns'
          SENDER='com.apple.controlcenter'
          ;;
        *)
          APP_ICON='/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertCautionIcon.icns'
          SENDER='com.apple.ActivityMonitor'
          ;;
      esac

      su "${CURRENT_USER}" -c "'#{Formula["reattach-to-user-namespace"].opt_bin}/reattach-to-user-namespace' '#{Formula["terminal-notifier"].opt_bin}/terminal-notifier' -ignoreDnD -appIcon '${APP_ICON}' -sender '${SENDER}' -title 'UPS' -message '${@}'"
    EOS

    chmod "+x", prefix/"etc/nut/notify.sh"
  end
end
