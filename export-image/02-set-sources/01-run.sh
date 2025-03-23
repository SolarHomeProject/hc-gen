#!/bin/bash -e

rm -f "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache"
find "${ROOTFS_DIR}/var/lib/apt/lists/" -type f -delete
on_chroot << EOF
apt update
apt -y dist-upgrade --auto-remove --purge
apt clean
EOF
