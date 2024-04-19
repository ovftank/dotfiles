#!/bin/bash

status_file=~/.config/polybar/scripts/wifi/wifi-status.txt
if [ -f "$status_file" ]; then
    echo "$(cat "$status_file")"
    exit
fi
wifi_name=$(nmcli device show | awk -F': +' '/GENERAL.CONNECTION/ {print $2}' | head -n1)
wifi_info=$(nmcli -t -f SSID,SIGNAL dev wifi | grep "$wifi_name" | head -n 1)

ssid=$(echo "$wifi_info" | cut -d ':' -f 1)
signal_strength=$(echo "$wifi_info" | cut -d ':' -f 2)

if [ -n "$ssid" ]; then
    if ((signal_strength >= 70)); then
        color="#50FA7B"
        signal_icon="󰤨"
    elif ((signal_strength >= 40)); then
        color="#F1FA8C"
        signal_icon="󰤢"
    else
        color="#FF5555"
        signal_icon="󰤯"
    fi
    echo "%{F$color}$signal_icon%{F-} $ssid"
else
    signal_icon="󰤮"
    echo "%{F#FF5555}$signal_icon%{F-}"
fi
