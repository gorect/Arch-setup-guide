#!/bin/bash

##Set Timezone
timedatectl set-ntp true
timedatectl status
sleep 3

##Create the File system and mount it----------------------------------------------------
echo "Make File System"
mkfs.ext4 -F /dev/sda1
mount /dev/sda1 /mnt

##Add DNS Entry to the resolv.conf file-------------------------------------------------
##echo "nameserver 8.8.4.4" >> /etc/resolv.conf
##echo "nameserver 8.8.8.8" >> /etc/resolv.conf

##Grab the completed pacman mirrorlist---------------------------------------------------
wget https://raw.github.com/gorect/Arch-Setup/master/usMirrorlist
mv usMirrorlist /etc/pacman.d/mirrorlist

##Pacstrap-------------------------------------------------------------------------------
pacstrap /mnt base linux linux-firmware

##Grenerate fstab------------------------------------------------------------------------
genfstab -U /mnt >> /mnt/etc/fstab

##Mount Jailed Root
arch-chroot /mnt
