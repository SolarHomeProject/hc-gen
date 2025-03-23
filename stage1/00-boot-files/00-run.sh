#!/bin/bash -e

mkdir -p "${ROOTFS_DIR}/boot/firmware"

install -m 644 files/cmdline.txt "${ROOTFS_DIR}/boot/firmware/"
install -m 644 files/config.txt "${ROOTFS_DIR}/boot/firmware/"
