#!/bin/bash
for term in $@; do
  search="$search%20$term"
done
xdg-open "https://www.google.com/search?q=site%3Agithub.com$search"
