#!/bin/bash
killall pulseaudio
pulseaudio -k
sleep 1
pulseaudio --start -D
pulseaudio-ctl mute
