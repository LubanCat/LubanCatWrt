#
# Copyright (C) 2013-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=imx6ull
BOARDNAME:=Freescale i.MX 6ULL
FEATURES:=audio display fpu gpio rtc usb usbgadget squashfs ext4 targz nand ubifs
CPU_TYPE:=cortex-a7
CPU_SUBTYPE:=neon-vfpv4

KERNEL_PATCHVER:=4.14

include $(INCLUDE_DIR)/target.mk

KERNELNAME:=zImage dtbs

DEFAULT_PACKAGES += uboot-envtools 

$(eval $(call BuildTarget))
