#!/bin/bash -e

install -v -m 600 files/HT-LAN.nmconnection  "${ROOTFS_DIR}/etc/NetworkManager/system-connections/"
install -v -m 600 files/WIFI.nmconnection    "${ROOTFS_DIR}/etc/NetworkManager/system-connections/"
install -v -d					             "${ROOTFS_DIR}/etc/wpa_supplicant"
install -v -m 600 files/wpa_supplicant.conf  "${ROOTFS_DIR}/etc/wpa_supplicant/"
install -m 755    files/generate_nm_conn_ids "${ROOTFS_DIR}/etc/init.d/"

if [ -v WPA_COUNTRY ]; then
	on_chroot <<- EOF
		sed -i -e "s/\s*cfg80211.ieee80211_regdom=\S*//" -e "s/\(.*\)/\1 cfg80211.ieee80211_regdom=$WPA_COUNTRY/" /boot/firmware/$(cat /proc/device-tree/chosen/os_prefix)cmdline.txt
	EOF
fi

on_chroot <<- EOF
	systemctl enable generate_nm_conn_ids
EOF