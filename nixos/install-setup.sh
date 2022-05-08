#!/bin/env bash

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
parted "$DISK" -- mkpart primary 512MiB 100%
echo "Creating boot partition"
parted "$DISK" -- mkpart ESP fat32 1MiB 512MiB
echo "Creating swap partition"
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

echo "Done"
