#!/bin/bash

# -----------------------------------------------------
# Version
# Gets the current version of te dotfiles
# -----------------------------------------------------
version=$(cat install/version)

# -----------------------------------------------------
# Library
# Checks if runnning virtualized
# -----------------------------------------------------
source install/includes/library.sh

# -----------------------------------------------------
# Header
# Displays header info about the dotfiles
# -----------------------------------------------------
source install/includes/header.sh

# -----------------------------------------------------
# Check supported Linux distribution
# -----------------------------------------------------
source install/includes/checkdistro.sh

# -----------------------------------------------------
# Load Library for used distro
# -----------------------------------------------------
source install/$installer/library.sh

# -----------------------------------------------------
# Install required packages
# -----------------------------------------------------
source install/$installer/install_required.sh

# -----------------------------------------------------
# Confirm Start
# -----------------------------------------------------
source install/includes/confirm.sh

# -----------------------------------------------------
# Preparation
# -----------------------------------------------------
source install/includes/preparation.sh

# -----------------------------------------------------
# Install Hyprland Packages
# -----------------------------------------------------
source install/$installer/install_packages.sh

# -----------------------------------------------------
# Create Backup
# -----------------------------------------------------
source install/includes/backup.sh

# -----------------------------------------------------
# Restore settings
# -----------------------------------------------------
source install/includes/restore.sh

# -----------------------------------------------------
# Keyboard
# -----------------------------------------------------
source install/includes/keyboard.sh

# -----------------------------------------------------
# Screen Resolution
# -----------------------------------------------------
source install/includes/monitor.sh

# -----------------------------------------------------
# KVM
# -----------------------------------------------------
source install/includes/kvm.sh

# -----------------------------------------------------
# Configure applications
# -----------------------------------------------------
source install/includes/apps.sh

# -----------------------------------------------------
# Copy the configuration
# -----------------------------------------------------
source install/includes/copy.sh

# -----------------------------------------------------
# Reboot
# -----------------------------------------------------
source install/includes/reboot.sh
