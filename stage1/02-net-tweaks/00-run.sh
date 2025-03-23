#!/bin/bash -e

echo "${TARGET_HOSTNAME}" > "${ROOTFS_DIR}/etc/hostname"
echo "127.0.1.1		${TARGET_HOSTNAME}" >> "${ROOTFS_DIR}/etc/hosts"

on_chroot << EOF
	ln -sf /dev/null /etc/systemd/network/99-default.link
        ln -sf /dev/null /etc/systemd/network/73-usb-net-by-mac.link
EOF
