#!/bin/bash

battery_info=$(acpi -b)
charging_status=$(acpi -a | awk '{print $3}')
if [ "$charging_status" = "on-line" ]; then
    battery_status="󰂄"
    battery_percentage=$(echo "$battery_info" | awk '{print $4}' | tr -d '%,')
    if ((battery_percentage == "charging")); then
        battery_percentage=$(echo "$battery_info" | awk '{print $5}' | tr -d '%,')
    fi
else
    battery_percentage=$(echo "$battery_info" | awk '{print $4}' | tr -d '%,')
fi
if (($(echo "$battery_percentage < 20" | bc -l))); then
    battery_status="󰁻"
    color="#FF5555"
elif (($(echo "$battery_percentage >= 20 && $battery_percentage <= 50" | bc -l))); then
    battery_status="󰁽"
    color="#F1FA8C"
elif (($(echo "$battery_percentage > 50 && $battery_percentage <= 80" | bc -l))); then
    battery_status="󰂀"
    color="#50FA7B"
else
    battery_status="󰂁"
    color="#8BE9FD"
fi
if [ "$charging_status" = "on-line" ]; then
    battery_status="󰂄"
fi

echo "$battery_status %{F$color}$battery_percentage%%{F-}"
