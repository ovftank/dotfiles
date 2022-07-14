#!/bin/bash
SHOW_VOLUME=$(pulseaudio-ctl full-status | awk '{print $2}' | grep -w "no")
if [ -z "$SHOW_VOLUME" ]; then
  echo " 0"
else
  echo " $(pulseaudio-ctl full-status | awk '{print $1}')"
fi
