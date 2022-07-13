#!/bin/bash
CHECK_INPUT_METHOD=$(ibus engine)

if [ "$CHECK_INPUT_METHOD" = "Bamboo" ]; then
  ibus engine "BambooUs"
else
  ibus engine "Bamboo"
fi
