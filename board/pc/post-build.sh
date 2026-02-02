#!/bin/sh

set -e

BOARD_DIR=$(dirname "$0")

# Detect boot strategy, EFI or BIOS
if [ -d "$BINARIES_DIR/efi-part/" ]; then
    cp -f "$BOARD_DIR/grub-efi.cfg" "$BINARIES_DIR/efi-part/EFI/BOOT/grub.cfg"
else
    cp -f "$BOARD_DIR/grub-bios.cfg" "$TARGET_DIR/boot/grub/grub.cfg"

    # Copy grub 1st stage to binaries, required for genimage
    cp -f "$TARGET_DIR/lib/grub/i386-pc/boot.img" "$BINARIES_DIR"
fi


#make StorageGroups dirs for mythbackend server usage
mkdir -p ${TARGET_DIR}/var/lib/mythtv
cd ${TARGET_DIR}/var/lib/mythtv
mkdir -p recordings livetv dbbackups videos trailers coverart fanart screenshots banners photographs music musicart
cd -

#enable getty.tty1.service
if [ -d ${TARGET_DIR}/etc/systemd ]; then
    mkdir -p "${TARGET_DIR}/etc/systemd/system/getty.target.wants"
    ln -sf /lib/systemd/system/getty@.service \
       "${TARGET_DIR}/etc/systemd/system/getty.target.wants/getty@tty1.service"
fi

#disable default autostart of some services
#
if [ -e ${TARGET_DIR}/usr/lib/systemd/system/mysqld.service ]; then
    sed -i 's/WantedBy=multi-user.target/#WantedBy=multi-user.target/' ${TARGET_DIR}/usr/lib/systemd/system/mysqld.service
fi

if [ -e ${TARGET_DIR}/usr/lib/systemd/system/lighttpd.service ]; then
    sed -i 's/WantedBy=multi-user.target/#WantedBy=multi-user.target/' ${TARGET_DIR}/usr/lib/systemd/system/lighttpd.service
fi

if [ -e ${TARGET_DIR}/usr/lib/systemd/system/samba.service ]; then
    sed -i 's/WantedBy=multi-user.target/#WantedBy=multi-user.target/' ${TARGET_DIR}/usr/lib/systemd/system/samba.service
    sed -i 's/WantedBy=multi-user.target/#WantedBy=multi-user.target/' ${TARGET_DIR}/usr/lib/systemd/system/samba-bgqd.service
    sed -i 's/WantedBy=multi-user.target/#WantedBy=multi-user.target/' ${TARGET_DIR}/usr/lib/systemd/system/smb.service
    sed -i 's/WantedBy=multi-user.target/#WantedBy=multi-user.target/' ${TARGET_DIR}/usr/lib/systemd/system/nmb.service
    sed -i 's/WantedBy=multi-user.target/#WantedBy=multi-user.target/' ${TARGET_DIR}/usr/lib/systemd/system/winbind.service
fi

if [ -e ${TARGET_DIR}/usr/lib/systemd/system/xfs_scrub_all.timer ]; then
    sed -i 's/WantedBy=timers.target/#WantedBy=timers.target/' ${TARGET_DIR}/usr/lib/systemd/system/xfs_scrub_all.timer
fi
