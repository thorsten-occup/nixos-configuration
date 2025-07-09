#! /run/current-system/sw/bin/bash

set -e

# Configuration
localpath="."
remotepath="https://tinyurl.com/mynixostest/modules"
files=(
  "configuration.nix"
  "accounts.nix"
)

for file in "${files[@]}"
do
  echo "FILE: $file"
done

exit 0

function confirm2continue {
    echo -e "Are you sure you wish to continue?"
    read -p "Please type \"YES\" -> "
    if [ "$REPLY" != "YES" ]; then
        exit
    fi
}

function getSwapSize {
    # based on https://itsfoss.com/swap-size
    local memory=$(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE) / (1024 * 1024 * 1024 ) + 3 ))
    # "bc" not available in minimal image :-( (temporary workaround above)
    # echo $(echo "scale=0;$memory + sqrt($memory)" | bc)
    echo $memory
}

function getProductName {
    # productname=$(lshw -class system -sanitize | grep "product: " | cut -f 2 -d ':')
    # productid=$(cksum <<< $productname | cut -f 1 -d ' ')
    # echo $productid
}

# Some warnings!
echo -e "\nWARNING\n-------\nThis script will delete EVERYTHING and re-partition your hard drive!!"
confirm2continue

# Collect information
echo -e "\nINSTALLATION TARGET\n-------------------"
options=($(lsblk --paths --nodeps --output NAME --noheading))
PS3="Please select -> "
select target in "${options[@]}"; do
    if [[ " ${options[*]} " =~ " ${target} " ]]; then
        echo "Usinig $target for installation"
	break
    fi
done

# read password for disk encryption
echo -e "\nDISK ENCRYPTION PASSWORD\n-------------------"
while true; do
  read -s -p "Password         -> " password
  echo
  read -s -p "Password (again) -> " password2
  echo
  [ "$password" = "$password2" ] && break
  echo "Passwords don't match! Please try again."
done

# What will be done?
echo -e "\nCONFIGURATION SUMMARY\n---------------------"

swapSize=$(getSwapSize)
echo "Installation target: ${target}"
echo "SWAP size: ${swapSize} (for hibernation)"
echo "Partitions:"
echo -e "\tESP - from 1MiB to 512MiB (fat32)"
echo -e "\troot - from 512MiB to ${swapSize}GiB before the end"
echo -e "\tswap - the last ${swapSize}GiB"

echo -e "\nReady to delete ALL your data on ${target}!"
confirm2continue

# Do it

# Wipe target device
echo -e "\nWiping ${target} ..."
blkdiscard -f -v ${target}
wipefs -a ${target}

# Partitioning
# possible alternative sfdisk https://superuser.com/a/1132834
echo -e "\nCreating partitions:"
echo -e "[1/5] Create partition table"
parted ${target} -- mklabel gpt
echo -e "[2/5] Create root partition"
parted ${target} -- mkpart ROOT 512MiB -${swapSize}GiB
echo -e "[3/5] Create swap partition"
parted ${target} -- mkpart SWAP linux-swap -${swapSize}GiB 100%
echo -e "[4/5] Create boot partition"
parted ${target} -- mkpart ESP fat32 1MiB 512MiB
echo -e "[5/5] Mark boot as ESP"
parted ${target} -- set 3 esp on
echo -e "[-/-] Partitions created"

# Setup LUKS
echo -e "\nSetting up LUKS:"
echo -e "[1/2] Creating encrypted disk"
echo -n $password | cryptsetup luksFormat --batch-mode /dev/disk/by-partlabel/ROOT -d -
echo -e "[2/2] Opening disk"
echo -n $password | cryptsetup luksOpen /dev/disk/by-partlabel/ROOT cryptroot -

# Format
echo -e "\nFormatting partitions:"
#echo "mkfs.ext4 -L nixos /dev/disk/by-partlabel/ROOT"
echo -e "[1/3]"
mkfs.ext4 -L nixos /dev/mapper/cryptroot
echo -e "[2/3]"
mkswap -L swap /dev/disk/by-partlabel/SWAP
echo -e "[3/3]"
mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/ESP

# Prepare installation
echo -e "\nMounting devices"
echo -e "[1/4]"
mount /dev/disk/by-label/nixos /mnt
echo -e "[2/4]"
mkdir -p /mnt/boot
echo -e "[3/4]"
mount /dev/disk/by-label/boot /mnt/boot
echo -e "[4/4]"
swapon /dev/disk/by-label/swap

# Generate config
echo -e "Generating config"
nixos-generate-config --root /mnt

# todo
# - download and configure nix files
# curl -L https://tinyurl.com/mynixostest/install.sh --output install.sh
