#!/bin/bash
CHECK_MODE=$(cat ~/.config/picom/picom.conf | grep "active-opacity = 1;")
CHECK_PROCESS=$(ps -A | grep picom | wc -l)
if [ "$CHECK_PROCESS" = 0 ]; then
  if [ "$CHECK_MODE" ]; then
    ln -sf ~/.config/i3/script/picom/mode-1 ~/.config/picom/picom.conf
    picom -b
  else
    ln -sf ~/.config/i3/script/picom/mode-2 ~/.config/picom/picom.conf
    picom -b
  fi
  sleep 1
else
  pkill picom
fi
