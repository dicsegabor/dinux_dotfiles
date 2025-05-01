#!/bin/bash

# Options for dmenu
options="Restart\nShutdown\nChange User\nLogout\nSleep"

# Always display the representing character
echo "   "

# Handle click events
case $BLOCK_BUTTON in
1) # Left click: Open the power menu
  choice=$(echo -e "$options" | dmenu -i -p " Power Menu:")
  if [ -n "$choice" ]; then
    confirm=$(echo -e "No\nYes" | dmenu -i -p "Are you sure you want to $choice?")
    if [ "$confirm" == "Yes" ]; then
      case "$choice" in
      "Logout")
        i3-msg exit
        ;;
      "Restart")
        systemctl reboot
        ;;
      "Shutdown")
        systemctl poweroff
        ;;
      "Change User")
        dm-tool switch-to-greeter
        ;;
      "Sleep")
        systemctl suspend
        ;;
      *)
        # Do nothing on invalid or no selection
        exit 1
        ;;
      esac
    fi
  fi
  ;;
esac
