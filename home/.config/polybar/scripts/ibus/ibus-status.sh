#!/bin/bash

CHECK_INPUT_METHOD=$(ibus engine 2>/dev/null)
if [ -z "$CHECK_INPUT_METHOD" ]; then
  echo "%{F#8BE9FD}EN%{F-}"
  exit
fi

if [ "$CHECK_INPUT_METHOD" = "Bamboo" ]; then
  echo "%{F#FF5555}VN%{F-}"
else
  echo "%{F#8BE9FD}EN%{F-}"
fi
