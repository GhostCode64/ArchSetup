#!/bin/bash

echo "Before continuing, please verify that you are chrooted into the Arch install and..."
read -p "... press enter to continue or CTRL+C to cancel install"

echo " █████╗ ██████╗  ██████╗██╗  ██╗    ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗         ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗"
echo "██╔══██╗██╔══██╗██╔════╝██║  ██║    ██║     ██║████╗  ██║██║   ██║╚██╗██╔╝    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║         ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝"
echo "███████║██████╔╝██║     ███████║    ██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝     ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║         ███████╗██║     ██████╔╝██║██████╔╝   ██║   "
echo "██╔══██║██╔══██╗██║     ██╔══██║    ██║     ██║██║╚██╗██║██║   ██║ ██╔██╗     ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║         ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   "
echo "██║  ██║██║  ██║╚██████╗██║  ██║    ███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗    ███████║╚██████╗██║  ██║██║██║        ██║   "
echo "╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   "
echo "version 0.0.1"
echo ""

echo "Setting the keyboard layout..."
loadkeys uk

echo "Checking internet connection..."
echo ""
ping -c 10 archlinux.org
echo ""
echo "Please verify that this device is connected to the internet and... "
read -p "... press enter to continue or CTRL+C to cancel install"

echo "Setting time zone..."
ln -sf /usr/share/zoneinfo/GB /etc/localtime
hwclock --systohc

echo "Please ensure that the time and date is accurate: "
timedatectl set-ntp true
timedatectl status
echo "Please verify that this device's time is correct and... "
read -p "... press enter to continue or CTRL+C to cancel install"

echo "Setting locale..."
echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=uk" > /etc/vconsole.conf

echo "Configuring network..."
echo "cobalt" > /etc/hostname
echo "127.0.0.1         localhost" >> /etc/hosts
echo "::1               localhost" >> /etc/hosts
echo "127.0.0.1         cobalt.localdomain      cobalt" >> /etc/hosts

echo "Setting password..."
passwd

#echo "Installing microcode..."
#pacman -S --no-confirm amd-ucode

echo "Setting up bootloader..."
DIRECTORY=/sys/firmware/efi
#check if UEFI or BIOS
if [ ! -d "$DIRECTORY" ]; then
    echo "haha bios"
else
    echo "Haha uefi"
fi

echo "Installing extra packages"
pacman -S --no-confirm git man