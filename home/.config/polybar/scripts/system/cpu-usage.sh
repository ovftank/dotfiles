#!/bin/bash

output=$(top -bn1)
cpu_line=$(echo "$output" | grep '^%Cpu(s):')
cpu_percentage=$(echo "$cpu_line" | awk '{print $2}' | tr ',' '.')

if (($(echo "$cpu_percentage < 40" | bc -l))); then
    color="#50FA7B"
elif (($(echo "$cpu_percentage >= 40 && $cpu_percentage <= 60" | bc -l))); then
    color="#F1FA8C"
elif (($(echo "$cpu_percentage > 60 && $cpu_percentage <= 80" | bc -l))); then
    color="#FFB86C"
else
    color="#FF5555"
fi
echo " %{F$color}$cpu_percentage%%{F-}"