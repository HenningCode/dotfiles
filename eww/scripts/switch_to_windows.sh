#!/bin/bash
WINDOWS_ENTRY=`grep menuentry /boot/grub/grub.cfg  | grep --line-number Windows`
MENU_NUMBER=$(( `echo $WINDOWS_ENTRY | sed -e "s/:.*//"` - 1 ))
sudo grub-reboot $MENU_NUMBER
sudo reboot
