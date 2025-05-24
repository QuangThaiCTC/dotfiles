#!/bin/bash

default_dir="$HOME/.local/share/wallpapers"

# Mở hộp thoại chọn file ảnh
imgpath=$(zenity --file-selection --title="Choose Wallpaper" --file-filter="*.png *.jpg *.jpeg *.webp *.gif")

# Nếu không chọn gì thì thoát
if [ -z "$imgpath" ]; then
    echo "Aborted"
    exit 0
fi

# Start swww-daemon nếu chưa chạy
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

swww img "$imgpath" --transition-step 100 --transition-fps 120 \
		--transition-type grow --transition-angle 30 --transition-duration 1 \
		--transition-pos
