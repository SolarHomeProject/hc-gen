#!/bin/bash -e

install -d "${ROOTFS_DIR}/usr/lib/sys-mods"
install -m 755 files/firstboot	"${ROOTFS_DIR}/usr/lib/sys-mods/"
install -m 755 files/get_fw_loc	"${ROOTFS_DIR}/usr/lib/sys-mods/"
install -m 755 files/regenerate_ssh_host_keys	"${ROOTFS_DIR}/usr/lib/sys-mods/"
install -m 644 files/regenerate_ssh_host_keys.service	"${ROOTFS_DIR}/usr/lib/systemd/system/"
install -m 755 files/resize2fs_once	"${ROOTFS_DIR}/etc/init.d/"
install -m 755 files/init_hdmi_audio	"${ROOTFS_DIR}/etc/init.d/"

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' "${ROOTFS_DIR}"/etc/ssh/sshd_config

on_chroot << EOF
systemctl disable hwclock.sh
if [ "${ENABLE_SSH}" == "1" ]; then
	systemctl enable ssh
else
	systemctl disable ssh
fi
systemctl enable regenerate_ssh_host_keys.service
systemctl enable init_hdmi_audio.service
EOF

if [ "${USE_QEMU}" = "1" ]; then
	echo "enter QEMU mode"
	install -m 644 files/90-qemu.rules "${ROOTFS_DIR}/etc/udev/rules.d/"
	on_chroot << EOF
systemctl disable resize2fs_once
EOF
	echo "leaving QEMU mode"
else
	on_chroot << EOF
systemctl enable resize2fs_once
EOF
fi

rm -f "${ROOTFS_DIR}/etc/ssh/"ssh_host_*_key*
