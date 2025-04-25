#!/bin/bash

# -----------------------------------------------------
# Functions for Setup
# -----------------------------------------------------

distro=""
installer=""

# Detect Linux Distribution
_detectDistro() {
  if [ -f /etc/arch-release ]; then
    distro="arch"
    installer="arch"
    echo ":: Installer for Arch"
  fi
}

# Check if package is installed
_isInstalledPacman() {
  package="$1"
  check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
  if [ -n "${check}" ]; then
    echo 0 #'0' means 'true' in Bash
    return #true
  fi
  echo 1 #'1' means 'false' in Bash
  return #false
}

# Install required packages
_installPackagesPacman() {
  toInstall=()
  for pkg; do
    if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
      echo "${pkg} is already installed."
      continue
    fi
    toInstall+=("${pkg}")
  done
  if [[ "${toInstall[@]}" == "" ]]; then
    # echo "All pacman packages are already installed.";
    return
  fi
  printf "Package not installed:\n%s\n" "${toInstall[@]}"
  sudo pacman --noconfirm -S "${toInstall[@]}"
}

# -----------------------------------------------------
# Packages
# -----------------------------------------------------

# Required packages for the installer on Arch
installer_packages_arch=(
  "figlet"
  "git"
)

clear

# Some colors
GREEN='\033[0;32m'
NONE='\033[0m'

# Header
echo -e "${GREEN}"
cat <<"EOF"
 ____       _               
/ ___|  ___| |_ _   _ _ __  
\___ \ / _ \ __| | | | '_ \ 
 ___) |  __/ |_| |_| | |_) |
|____/ \___|\__|\__,_| .__/ 
                     |_|    

EOF
echo "for Dinux dotfiles"
echo
echo -e "${NONE}"

echo "This script will download the Dinux dotfiles and start the installation."
echo
while true; do
  read -p "DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn): " yn
  case $yn in
  [Yy]*)
    echo "Installation started."
    echo
    break
    ;;
  [Nn]*)
    echo "Installation canceled."
    exit
    break
    ;;
  *) echo "Please answer yes or no." ;;
  esac
done

# -----------------------------------------------------
# Detect Distribution
# -----------------------------------------------------
_detectDistro
if [ -z $distro ]; then
  echo "ERROR: Your Linux distribution could not be detected or is not supported."
  echo
  echo "Please select one of the following installation profiles or cancel the installation."
  echo
  version=$(gum choose "arch" "fedora" "cancel")
  if [ "$version" == "arch" ]; then
    echo ":: Installer for Arch"
    distro="arch"
    installer="arch"
  elif [ "$version" == "cancel" ]; then
    echo ":: Setup canceled"
    exit 130
  else
    echo ":: Setup canceled"
    exit 130
  fi
fi

# -----------------------------------------------------
# Installation for Arch
# -----------------------------------------------------
if [ "$installer" == "arch" ]; then
  _installPackagesPacman "${installer_packages_arch[@]}"
fi

# Create Downloads folder if not exists
if [ ! -d ~/Downloads ]; then
  mkdir ~/Downloads
  echo ":: Downloads folder created"
fi

# Change into Downloads directory
cd ~/Downloads

# Remove existing folder
if [ -d ~/Downloads/dinux_dotfiles ]; then
  rm -rf ~/Downloads/dinux_dotfiles
  echo ":: Existing installation folder removed"
fi

# Clone the packages
git clone --depth 1 https://github.com/mylinuxforwork/hyprland-starter.git
echo ":: Installation files cloned into Downloads folder"

# Change into the folder
cd hyprland-starter

# Start the script
./install.sh
