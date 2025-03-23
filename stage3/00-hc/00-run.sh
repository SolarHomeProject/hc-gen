#!/bin/bash -e

install -m 644 files/homecontrol_1.0.0_arm64.deb	"${ROOTFS_DIR}/root/"

on_chroot << EOF
apt -o Acquire::Retries=3 install --no-install-recommends -y /root/homecontrol_1.0.0_arm64.deb
rm /root/homecontrol_1.0.0_arm64.deb
EOF
