#!/usr/bin/env bash
case "$1" in
reboot)
  label="Yes, reboot"
  cmd="systemctl reboot"
  ;;
poweroff)
  label="Yes, shut down"
  cmd="systemctl poweroff"
  ;;
*) exit 1 ;;
esac
choice=$(printf 'No\n%s\n' "$label" | wofi --dmenu --conf ~/.config/wofi/powermenu-config --style ~/.config/wofi/powermenu-style.css --prompt "$1?" --lines 3)
[ "$choice" = "$label" ] && $cmd
