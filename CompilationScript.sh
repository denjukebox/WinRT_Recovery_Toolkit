#!/bin/bash

# Name of device recovery image for resources folderDEFAULT Surface_RT1
DEVICE_NAME=$1
# Version of windows to use
WIN_VERSION=$2
# Type of image for device in device recovery fs folder
IMAGE_VARIANT=$3
#Compound image name & location
IMAGE_NAME="${DEVICE_NAME}_WinRT_${WIN_VERSION}_${IMAGE_VARIANT}"
IMAGE_LOCATION="ISO/${IMAGE_NAME}.iso"

echo $IMAGE_NAME

LODEV=$(sudo losetup -f)
fallocate -l 500MiB ${IMAGE_LOCATION}
sudo -s <<EOF
losetup --partscan --show --find "${IMAGE_LOCATION}"
(echo o; echo n; echo p; echo 1; echo ""; echo ""; echo "t"; echo "b"; echo w; echo q) | fdisk $(echo $LODEV)
mkfs.vfat -n "RECOVERY" -M 0xF9 -v "${LODEV}p1"
mount "${LODEV}p1" mount
unzip "Resources/RecoveryFS/${DEVICE_NAME}/WinRT_${WIN_VERSION}_${IMAGE_VARIANT}.zip" -d mount
cp -r -v Resources/Windows mount
cp -r -v Resources/Linux mount
cp -r -v Scripts mount
cp -v menu.cmd  mount
umount mount
losetup -d $(echo $LODEV)
EOF
exit 0
#unzip "Resources/Installs/WinRT_${WIN_VERSION}_${IMAGE_VARIANT}.zip" -d mount/sources
