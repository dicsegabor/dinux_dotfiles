# -----------------------------------------------------
# Install packages
# -----------------------------------------------------

# 🧱 Base system / core utilities
base_packages=(
  "xdg-desktop-portal"
  "xdg-desktop-portal-gtk"
  "fuse2"
  "jq"
  "zip"
  "reflector"
)

# 🎨 Window manager and session
wm_packages=(
  "i3"
  "i3blocks"
  "i3lock"
  "dmenu"
  "dunst"
)

# 📺 Applications
app_packages=(
  "alacritty" # Terminal
  "starship"  # Custom prompt for terminal
  "ranger"    # File manager
  "firefox"   # Browser
  "vim"       # Text editor
  "fastfetch" # System info
  "vlc"       # Media player
)

# 🧰 Libraries / runtimes / GUI support
lib_packages=(
  "gtk4"
  "libadwaita"
  "python-gobject"
)

# 🖼️ Fonts
font_packages=(
  "ttf-font-awesome"
)

audio_tools=(
  "pipewire"
  "pipewire-alsa"
  "pipewire-pulse"
  "pipewire-audio"
  "wireplumber"
  "pulsemixer" # Terminal based audio mixer
)

network_tools=(
  "networkmanager"
  "opensssh"
  "smbclient"
  "wireguard"
  "wiregurad-tools"
  "tailscale"
)

# ⚙️ System control & input tools
util_packages=(
  "xdotool"
  "brightnessctl"
)

# -----------------------------------------------------
# Combine all packages into one array
# -----------------------------------------------------
installer_packages=(
  "${base_packages[@]}"
  "${wm_packages[@]}"
  "${app_packages[@]}"
  "${lib_packages[@]}"
  "${audio_tools[@]}"
  "${network_tools[@]}"
  "${font_packages[@]}"
  "${util_packages[@]}"
)

installer_yay=(
  "wlogout"
)

# PLEASE NOTE: Add more packages at the end of the following command
_installPackages "${installer_packages[@]}"
_installPackagesYay "${installer_yay[@]}"
