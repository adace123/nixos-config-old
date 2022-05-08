#!/bin/env bash

set -x
shopt -s nocasematch

DISK="${1:-/dev/sda}"

DIVIDER=""

if [ ! -b "$DISK" ]; then
   echo "Error: No such block device $DISK"
   lsblk
   exit 1
fi

read -p "WARNING: Will partition and reformat disk "$DISK". Continue? (y/n) " confirmation

if [[ "$confirmation" != "y" ]]; then
   echo "Not performing operation"
   exit 0
fi

echo "Creating partitions on disk $DISK"
parted "$DISK" -- mklabel gpt
echo "Creating root partition"
parted "$DISK" -- mkpart primary 512MiB -4GiB
echo "Creating swap partition"
parted "$DISK" -- mkpart primary linux-swap -4GiB 100%
echo "Creating boot partition"
parted "$DISK" -- mkpart ESP fat32 1MiB 512MiB
parted "$DISK" -- set 3 esp on

echo "Finished creating partitions"
fdisk -l

echo "Creating root filesystem"
mkfs.ext4 -L nixos "${DISK}${DIVIDER}1"
echo "Creating swap filesystem"
mkswap -L swap "${DISK}${DIVIDER}2"
echo "Creating boot filesystem"
mkfs.fat -F 32 -n boot "${DISK}${DIVIDER}3"

echo "Mounting root filesystem"
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
echo "Mounting boot filesystem"
mount /dev/disk/by-label/boot /mnt/boot
echo "Enabling swap"
swapon "${DISK}${DIVIDER}2"

echo "Installing Nixos"
NIX_SHELL_PKGS="git vim nixFlakes"

# Run these commands prior to this script
# nix-shell --run "git clone https://github.com/adace123/nixos-config" -p "$NIX_SHELL_PKGS"
# nix-shell --run "sudo git config --global --add safe.directory /home/nixos/nixos-config" -p "$NIX_SHELL_PKGS"

nix-shell --run "sudo nixos-install --flake nixos-config#aaron-vm" -p "$NIX_SHELL_PKGS"
