#!/bin/bash -e

install -m 755 files/initramfs-tools/hooks/firstboot	"${ROOTFS_DIR}/usr/share/initramfs-tools/hooks/"
install -m 755 files/initramfs-tools/scripts/local-premount/firstboot	"${ROOTFS_DIR}/usr/share/initramfs-tools/scripts/local-premount/"

if [ -f "${ROOTFS_DIR}/etc/initramfs-tools/update-initramfs.conf" ]; then
	sed -i 's/^update_initramfs=.*/update_initramfs=no/' "${ROOTFS_DIR}/etc/initramfs-tools/update-initramfs.conf"
fi

if [ ! -f "${ROOTFS_DIR}/etc/kernel-img.conf" ]; then
	echo "do_symlinks=0" > "${ROOTFS_DIR}/etc/kernel-img.conf"
fi
rm -f "${ROOTFS_DIR}/"{vmlinuz,initrd.img}*
