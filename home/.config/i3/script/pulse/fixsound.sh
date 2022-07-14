#!/bin/bash
fix_pulseaudio(){
  pulseaudio --k
  killall pulseaudio
  sleep 1
  pulseaudio --start -D
}

fix_pulseaudio
