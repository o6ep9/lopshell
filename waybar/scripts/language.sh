#!/usr/bin/env bash
render() {
  km=$(hyprctl -j devices | jq -r '.keyboards[] | select(.main == true) | .active_keymap')
  case "$km" in
    Russian*) echo " [ ru ] " ;;
    *)        echo " [ en ] " ;;
  esac
}
render
socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
  while read -r line; do
    case "$line" in activelayout*) render ;; esac
  done