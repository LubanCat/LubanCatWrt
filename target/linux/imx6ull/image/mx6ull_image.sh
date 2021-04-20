#!/usr/bin/env bash
#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

set -ex
[ $# -eq 6 ] || {
    echo "SYNTAX: $0 <file> <bootfs image> <rootfs image> <bootfs size> <rootfs size> <u-boot image>"
    exit 1
}

OUTPUT="$1"  # openwrt-imx6ull-imx6ull-ebf6ull-mmc-ext4-ebf6ull.img.gz
KERNELSIZE="$2" # 16
KERNELDIR="$3"  # openwrt-imx6ull-imx6ull-ebf6ull-mmc-ext4-ebf6ull.img.gz.kernel
ROOTFSSIZE="$4" # 104
ROOTFSIMAGE="$5"  # linux-imx6ull/root.ext4
UBOOT="$6" # u-boot-dtb.imx

set `ptgen -o $OUTPUT -h 10240 -s 8192 -l 1024 -t c -p ${KERNELSIZE}M -t 83 -p ${ROOTFSSIZE}M`

KERNELOFFSET="$(($1 / 512))"
KERNELSIZE="$(($2 / 512))"
ROOTFSOFFSET="$(($3 / 512))"
ROOTFSSIZE="$(($4 / 512))"

dd bs=1024 if="$UBOOT" of="$OUTPUT" seek=1 conv=fsync
dd bs=512 if="$KERNELDIR" of="$OUTPUT" seek="$KERNELOFFSET" conv=notrunc
dd bs=512 if="$ROOTFSIMAGE" of="$OUTPUT" seek="$ROOTFSOFFSET" conv=notrunc
