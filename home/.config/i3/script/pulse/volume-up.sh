#!/bin/bash
CHECK_MUTE=$(pulseaudio-ctl full-status | awk '{print $2}')
if [ "$CHECK_MUTE" = "yes" ]; then
    pulseaudio-ctl mute
    pulseaudio-ctl up
else
  pulseaudio-ctl up
fi
