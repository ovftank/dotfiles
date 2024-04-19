#!/bin/bash
ram_used=$(free | awk '/Mem:/ {print $3}')
ram_total=$(free | awk '/Mem:/ {print $2}')

ram_usage=$(echo "scale=2; ($ram_used / $ram_total) * 100" | bc)
ram_usage=$(echo "$ram_usage" | sed 's/\.00$//')

if (($(echo "$ram_usage < 40" | bc -l))); then
    color="#50FA7B"
elif (($(echo "$ram_usage >= 40 && $ram_usage <= 60" | bc -l))); then
    color="#F1FA8C"
elif (($(echo "$ram_usage > 60 && $ram_usage <= 80" | bc -l))); then
    color="#FFB86C"
else
    color="#FF5555"
fi
echo "  %{F$color}$ram_usage%%{F-}"
