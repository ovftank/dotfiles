# bin/bash
state_file=~/.config/polybar/scripts/coding-time/state.txt
result_full="$(~/.config/polybar/scripts/coding-time/wakatime.sh)"
ressul_mins="$(~/.config/polybar/scripts/coding-time/wakatime-min.sh)"
if [ ! -f "$state_file" ]; then
    echo "0" >"$state_file"
fi
state=$(cat "$state_file")
if [ "$state" -eq 0 ]; then
    echo "$result_full"
else
    echo "$ressul_mins"
fi
