if [ ! -f ~/.config/i3/conf/input.conf ]; then
  # Setup keyboard layout
  echo -e "${GREEN}"
  figlet "Keyboard"
  echo -e "${NONE}"
  echo "Please select your keyboard layout. Can be changed later in ~/-config/i3/hyprland.conf"
  echo "Start typing = Search, RETURN = Confirm, CTRL-C = Cancel"
  echo
  keyboard_layout=$(localectl list-x11-keymap-layouts | gum filter --height 15 --placeholder "Find your keyboard layout...")
  echo
  if [ -z $keyboard_layout ]; then
    keyboard_layout="us"
  fi
  SEARCH="kb_layout = us"
  REPLACE="kb_layout = $keyboard_layout"
  sed -i -e "s/$SEARCH/$REPLACE/g" ~/dinux/$version/.config/i3/conf/input.conf
  echo ":: Keyboard layout changed to $keyboard_layout"
  echo
else
  rm ~/dinux/$version/.config/i3/conf/input.conf
fi
