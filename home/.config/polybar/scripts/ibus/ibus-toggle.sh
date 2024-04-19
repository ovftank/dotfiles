#!/bin/bash
CHECK_INPUT_METHOD=$(ibus engine)

if [ "$CHECK_INPUT_METHOD" = "Bamboo" ]; then
  ibus engine "BambooUs"
  echo "US"
else
  ibus engine "Bamboo"
  echo "VN"
fi