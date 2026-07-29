#!/usr/bin/env bash
render() {
  hyprctl -j workspaces | jq -r --argjson a "$(hyprctl -j activeworkspace | jq .id)" \
    '[.[] | select(.id > 0)] | sort_by(.id) | map(if .id == $a then "[\(.id)]" else " \(.id) " end) | join(" ")'
}
render
socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
  while read -r _; do render; done