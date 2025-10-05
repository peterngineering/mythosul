#!/bin/sh
set -u
set -e


MKIMAGE=$HOST_DIR/bin/mkimage
BOARD_DIR="$(dirname $0)"

$MKIMAGE -n rk3288 -T rksd -d $BINARIES_DIR/u-boot-tpl.bin $BINARIES_DIR/u-boot-tpl.img
cat $BINARIES_DIR/u-boot-tpl.img $BINARIES_DIR/u-boot-spl-dtb.bin > $BINARIES_DIR/u-boot-tpl-spl-dtb.img

install -m 0644 -D $BOARD_DIR/extlinux.conf $TARGET_DIR/boot/extlinux/extlinux.conf

install -m 0755 -D output/build/linux-6.12.39/arch/arm/boot/dts/rockchip/rk3288-tinker.dtb $TARGET_DIR/boot/


#make StorageGroups dirs for mythtv
mkdir -p ${TARGET_DIR}/var/lib/mythtv
cd ${TARGET_DIR}/var/lib/mythtv
mkdir -p recordings livetv dbbackups videos trailers coverart fanart screenshots banners photographs music musicart
cd -
chown -R 1000:1000 ${TARGET_DIR}/var/lib/mythtv

# Add a console on tty1
# overlay currently has a autologin that should write over this for now
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
# systemd doesn't use /etc/inittab, enable getty.tty1.service instead
elif [ -d ${TARGET_DIR}/etc/systemd ]; then
    mkdir -p "${TARGET_DIR}/etc/systemd/system/getty.target.wants"
    ln -sf /lib/systemd/system/getty@.service \
       "${TARGET_DIR}/etc/systemd/system/getty.target.wants/getty@tty1.service"
fi

#move some pre installed server related out of init.d

if [ -e ${TARGET_DIR}/etc/init.d/S98mythbackend ]; then
    mkdir -p "${TARGET_DIR}/root/SVR"
    mv ${TARGET_DIR}/etc/init.d/S98mythbackend ${TARGET_DIR}/root/SVR
fi

#if [ -e ${TARGET_DIR}/etc/init.d/S??chronyd ]; then
#    mkdir -p "${TARGET_DIR}/root/SVR/NTPD"
#    mv ${TARGET_DIR}/etc/init.d/S??chronyd ${TARGET_DIR}/root/SVR/NTPD
#fi

if [ -e ${TARGET_DIR}/etc/init.d/S??mysqld ]; then
    mkdir -p "${TARGET_DIR}/root/SVR/DB"
    mv ${TARGET_DIR}/etc/init.d/S??mysqld ${TARGET_DIR}/root/SVR/DB
fi

if [ -e ${TARGET_DIR}/etc/init.d/S??dnsmasq ]; then
    mkdir -p "${TARGET_DIR}/root/SVR/DNS"
    mv ${TARGET_DIR}/etc/init.d/S??dnsmasq ${TARGET_DIR}/root/SVR/DNS
fi

if [ -e ${TARGET_DIR}/etc/init.d/S??iptables ]; then
    mkdir -p "${TARGET_DIR}/root/SVR/IPTABLES"
    mv ${TARGET_DIR}/etc/init.d/S??iptables ${TARGET_DIR}/root/SVR/IPTABLES
fi

if [ -e ${TARGET_DIR}/etc/init.d/S*hostapd ]; then
    mkdir -p "${TARGET_DIR}/root/SVR/AP"
    mv ${TARGET_DIR}/etc/init.d/S??hostapd ${TARGET_DIR}/root/SVR/AP
fi

if [ -e ${TARGET_DIR}/etc/init.d/S??lighttpd ]; then
    mkdir -p "${TARGET_DIR}/root/SVR/HTTPD"
    mv ${TARGET_DIR}/etc/init.d/S??lighttpd ${TARGET_DIR}/root/SVR/HTTPD
fi

if [ -e ${TARGET_DIR}/etc/init.d/S??smb ]; then
    mkdir -p "${TARGET_DIR}/root/SVR/SMB"
    mv ${TARGET_DIR}/etc/init.d/S??smb ${TARGET_DIR}/root/SVR/SMB
fi

#rpc/nfs/portmap
#if [ -e ${TARGET_DIR}/etc/init.d/S??nfsd ]; then
#    mkdir -p "${TARGET_DIR}/root/SVR/NFSD"
#    mv ${TARGET_DIR}/etc/init.d/S??nfsd /root/SVR/NFSD
#fi

