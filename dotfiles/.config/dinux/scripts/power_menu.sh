#!/bin/bash

# Options for dmenu
options="Restart\nShutdown\nChange User\nLogout\nSleep\nLock"

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
    "Lock")
      ~/.config/dinux/scripts/lock_with_blur.sh
      ;;
    *)
      exit 1
      ;;
    esac
  fi
fi
