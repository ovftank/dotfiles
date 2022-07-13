#!/bin/bash
pkill pulseaudio
pulseaudio -k
sleep 1
pulseaudio --start -D
pulseaudio-ctl mute
