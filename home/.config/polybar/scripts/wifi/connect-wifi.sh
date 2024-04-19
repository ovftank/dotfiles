#!/bin/bash

wifi_list=$(nmcli -t -f SSID dev wifi list)
selected_wifi=$(echo "$wifi_list" | rofi -dmenu -p "Choose WiFi")

if [ -n "$selected_wifi" ]; then
    if output=$(nmcli dev wifi connect "$selected_wifi"); then
        echo "$output"
    else
        password=$(rofi -dmenu -password -p "Enter Password for $selected_wifi")
        connect_output=$(nmcli device wifi connect "$selected_wifi" password "$password" 2>&1)
        if [[ $connect_output == *"Error"* ]]; then
            rofi -e "Connection Failed: $connect_output"
        else
            rofi -e "Connected to $selected_wifi"
        fi
    fi
fi
