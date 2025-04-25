echo -e "${GREEN}"
if [ -d ~/.config/dinux ]; then
  figlet "Update"
else
  figlet "Installation"
fi
echo -e "${NONE}"
echo "This script will install the Dinux i3 configuration."
echo
if gum confirm "DO YOU WANT TO START NOW?"; then
  echo
  echo ":: Installing i3 and required packages"
  echo
elif [ $? -eq 130 ]; then
  echo ":: Installation canceled"
  exit 130
else
  echo
  echo ":: Installation canceled"
  exit
fi
