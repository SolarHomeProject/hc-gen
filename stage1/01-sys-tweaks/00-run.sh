#!/bin/bash -e

install -v -m 644 files/fstab "${ROOTFS_DIR}/etc/fstab"

on_chroot << EOF
echo "root:hc" | chpasswd
EOF
