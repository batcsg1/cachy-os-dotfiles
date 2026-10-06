#!/usr/bin/env fish

set entries "󰐥 Shutdown" " Reboot" " Suspend" "󰩈 Exit Hyprland"

set selected (string join \n $entries | wofi --dmenu --conf ~/.config/wofi/powermenu-config --style ~/.config/wofi/powermenu-style.css --prompt "Menu")

switch "$selected"
    case "󰐥 Shutdown"
        shutdown now
    case " Reboot"
        reboot
    case " Suspend"
        suspend
    case "󰩈 Exit Hyprland"
        hyprctl dispatch exit
end
