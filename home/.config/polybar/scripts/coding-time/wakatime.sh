# bin/bash
result="$(wakatime --today | grep -o '[0-9]\+ hrs\? [0-9]\+ mins\?\| [0-9]\+ mins\?' | sed 's/hrs\?/*/;s/mins\?//')"
if [ -z "$result" ]; then
    result="$(wakatime --today | grep -o '[0-9]\+ mins' | sed 's/mins//')"
    total_minutes=$result
else
    IFS='*' read -r hours minutes <<<"$result"
    total_minutes=$((hours * 60 + minutes))
fi

if ((total_minutes >= 480)); then
    face=""
    color="#FF5555"
elif ((total_minutes >= 360)); then
    face=""
    color="#FF5555"
elif ((total_minutes >= 300)); then
    face=""
    color="#FF5555"
elif ((total_minutes >= 240)); then
    face=""
    color="#FFB86C"
elif ((total_minutes >= 180)); then
    face=""
    color="#FFB86C"
elif ((total_minutes >= 120)); then
    face=""
    color="#FFB86C"
elif ((total_minutes >= 60)); then
    face=""
    color="#F1FA8C"
else
    face=""
    color="#50FA7B"
fi
hours=$((total_minutes / 60))
if ((hours == 0)); then
    hours=""
elif ((hours == 1)); then
    hours="0$hours hr"
elif ((hours >= 2 && hours <= 9)); then
    hours="0$hours hrs"
elif ((hours >= 10)); then
    hours="$hours hrs"
fi
minutes=$((total_minutes % 60))
if ((minutes <= 10)); then
    minutes="0$minutes"
fi
echo "$face  %{F$color}$hours $minutes mins time coding%{F-}"
