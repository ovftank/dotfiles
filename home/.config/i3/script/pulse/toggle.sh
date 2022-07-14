#!/bin/bash
pulseaudio-ctl mute
CHECK_PULSE_AUDIO_DAEMON=$(ps -ef | grep pulseaudio | grep -v grep | wc -l)
if [ $CHECK_PULSE_AUDIO_DAEMON -eq 0 ]; then
  pulseaudio --start
fi
