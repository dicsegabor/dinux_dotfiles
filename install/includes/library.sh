# Colors to use later
GREEN='\033[0;32m'
NONE='\033[0m'

# isKVM
_isKVM() {
  iskvm=$(sudo dmesg | grep "Hypervisor detected")
  if [[ "$iskvm" =~ "KVM" ]]; then
    echo 0
  else
    echo 1
  fi
}
