#!/bin/bash -e

install -m 644 files/60-dma-heap.rules	"${ROOTFS_DIR}/lib/udev/rules.d/"
install -m 644 files/98-rpi.conf	"${ROOTFS_DIR}/etc/sysctl.d/"
install -m 755 files/switch2ondem_cpugov	"${ROOTFS_DIR}/etc/init.d/"

on_chroot << EOF
systemctl disable apt-daily-upgrade.service apt-daily-upgrade.timer apt-daily.service apt-daily.timer
systemctl disable getty@.service getty-static.service serial-getty@.service
systemctl mask getty@.service getty-static.service serial-getty@.service
systemctl enable switch2ondem_cpugov
printf "i2c-dev\n" >> /etc/modules
EOF