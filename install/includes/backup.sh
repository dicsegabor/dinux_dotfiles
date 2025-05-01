backup_files=(
  ".config/alacritty"
  ".config/dunst"
  ".config/i3"
  ".config/dinux"
  ".config/i3blocks"
  ".config/i3lock"
  ".bashrc"
)

echo -e "${GREEN}"
figlet "Backup"
echo -e "${NONE}"
echo "The script can create a backup of you existing configurations in .config and your .bashrc"
if gum confirm "Do you want to create a backup now"; then

  # Create dinux folder
  if [ ! -d ~/dinux ]; then
    mkdir ~/dinux
  fi

  # Get current timestamp
  datets=$(date '+%Y%m%d%H%M%S')

  # Create backup folder
  if [ ! -d ~/dinux/archive ]; then
    mkdir ~/dinux/archive
  fi

  # Create backup folder
  if [ ! -d ~/dinux/backup ]; then
    mkdir ~/dinux/backup
  else
    mkdir ~/dinux/archive/$datets
    cp -r ~/dinux/backup/. ~/dinux/archive/$datets/
  fi

  for df in "${backup_files[@]}"; do
    if [ -d ~/$df ]; then
      echo ":: Backup of $df"
      mkdir -p ~/dinux/backup/$df
      cp -r ~/$df ~/dinux/backup/$df
    fi
    if [ -f ~/$df ] && [ ! -L "${df}" ]; then
      echo ":: Backup of $df"
      cp ~/$df ~/dinux/backup/$df
    fi
  done
elif [ $? -eq 130 ]; then
  echo ":: Installation canceled"
  exit 130
else
  echo ":: Backup skipped"
fi
