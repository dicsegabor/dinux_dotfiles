#!/bin/bash

# Always display the representing character
echo "   "

# Handle click events
case $BLOCK_BUTTON in
1) # Left click: Open the power menu
  ~/.config/dinux/scripts/power_menu.sh
  ;;
esac
