killall pulseaudio
pulseaudio -k
sleep 2
pulseaudio --start -D
CHECK=`pulseaudio-ctl full-status | awk '{print $2}'`
if [[ "$CHECK" == "no" ]]; then
	pulseaudio-ctl set 100
	paplay -p ~/.config/i3/soundtest.wav
else
	pulseaudio-ctl mute
	pulseaudio-ctl set 100
	paplay -p ~/.config/i3/soundtest.wav
fi
