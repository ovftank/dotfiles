#!/bin/bash
state_file=~/.config/polybar/scripts/coding-time/state.txt
if [ ! -f "$state_file" ]; then
    echo "0" >"$state_file"
fi
state=$(cat "$state_file")
if [ "$state" -eq 0 ]; then
    echo "1" >"$state_file"
else
    echo "0" >"$state_file"
fi
