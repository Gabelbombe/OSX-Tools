#!/bin/bash
# http://pastebin.com/n1MCYxsF
# sudo dd if=ubuntu-14.04.1-desktop-amd64.img.dmg of=/dev/rdisk2 bs=1M
# http://askubuntu.com/questions/453252/setup-problems-ubuntu-14-04-wifi-on-macbookpro-13-3-w-retina-dual-boot

## ROOT check
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as su" 1>&2 ; exit 1
fi

cd /tmp/
wget -O 'refind.zip' 'http://downloads.sourceforge.net/project/refind/0.8.3/refind-bin-0.8.3.zip?r=&ts=1416423555&use_mirror=softlayer-dal'
unzip refind.zip && cd refind-bin-0.8.3

bash install.sh --esp --alldrivers
mkdir -p /Volumes/esp
mount -t msdos /dev/disk0s1 /Volumes/esp

cd /Volumes/esp
mv EFI/refind EFI/boot
mv EFI/boot/refind_x64.efi EFI/boot/bootx64.efi
cp -R /tmp/refind-bin-0.8.3/refind/drivers_x64 EFI/boot/drivers

