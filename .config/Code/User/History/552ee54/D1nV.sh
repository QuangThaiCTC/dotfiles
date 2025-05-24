#!/bin/bash

# Get workspace index and app class
mapfile -t ws < <(hyprctl clients -j | jq -r '.[] | "\(.workspace.id):\(.class)"')
declare -A icon_map=(
  [Alacritty]="󰍩"
  [kitty]="󰍩"
  [code]="󰙯"
  [VSCodium]="󰙯"
  [firefox]=""
  [Brave-browser]=""
  [thunar]="󰓇"
  [nemo]="󰉋"
  [discord]="󰙯"
)

result=""

for entry in "${ws[@]}"; do
  IFS=':' read -r index class <<< "$entry"
  icon="${icon_map[$class]:-}"  # default fallback icon
  result+="{\"name\":\"$class\",\"icon\":\"$icon\",\"id\":$index},"
done

echo "[${result%,}]"
