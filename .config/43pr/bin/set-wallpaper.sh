#!/usr/bin/env bash
# Usage: set-wallpaper.sh [image]   (no arg: random from ~/Pictures/Wallpapers)
# Sets the wallpaper on all outputs, then regenerates matugen colors and reloads consumers.
set -euo pipefail

img="${1:-}"
if [[ -z "$img" ]]; then
    img=$(find "$HOME/Pictures/Wallpapers" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) | shuf -n1)
fi
[[ -f "$img" ]] || { echo "set-wallpaper: not a file: $img" >&2; exit 1; }
img=$(realpath "$img")

awww img "$img" -t random --transition-duration 1
python3 "$HOME/.config/43pr/bin/theme.py" wallpaper "$img"
