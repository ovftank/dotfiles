#!/bin/bash
status_file=~/.config/polybar/scripts/wifi/wifi-status.txt
loading_icon=""
echo "$loading_icon" > "$status_file"
wifi_status=$(nmcli radio wifi)
if [ "$wifi_status" = "enabled" ]; then
    sudo nmcli radio wifi off
    echo "󰤮" > "$status_file"
else
    rm "$status_file"
    sudo nmcli radio wifi on
fi