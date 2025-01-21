#!/bin/bash

# Check for click events
case $BLOCK_BUTTON in
1) # Left click: Show the remaining time
  alacritty --command "curl -Ss 'https://wttr.in?hourly'"
  ;;
*) # Default: Show battery percentage with arrow
  curl -Ss 'https://wttr.in?0&T&Q' | cut -c 16- | head -2 | xargs echo
  ;;
esac
