#
# Copyright (C) 2013-2016 OpenWrt.org
# Copyright (C) 2016 Yousong Zhou
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

FAT32_BLOCKS=$(shell echo $$(($(CONFIG_TARGET_KERNEL_PARTSIZE)*1024)))

KERNEL_LOADADDR:=0x85000000

define Build/ebf6ull-img
	FAT32_BLOCKS=$(shell echo $$(($(CONFIG_TARGET_KERNEL_PARTSIZE)*1024*1024/1024)))

	rm -rf $@.kernel

	mkfs.fat $@.kernel -C $(FAT32_BLOCKS)
	cp $(DTS_DIR)/$(DEVICE_DTS).dtb $(DTS_DIR)/imx6ull-14x14-evk.dtb
	mcopy -i $@.kernel $(DTS_DIR)/imx6ull-14x14-evk.dtb ::dtb
	mcopy -i $@.kernel $(KERNEL_BUILD_DIR)/zImage ::zImage
	
	./mx6ull_image.sh \
		$@ \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) \
		$@.kernel \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) \
		$(IMAGE_ROOTFS) \
		$(BIN_DIR)/u-boot-mx6ull_ebf6ull_mmc/u-boot-dtb.imx

endef

define Build/imx6ull-ubootimg
	rm -f $@
	rm -f $@.pad
	dd if=/dev/zero of=$@.pad bs=1024 count=1
	cat $@.pad $(BIN_DIR)/u-boot-mx6ull_ebf6ull_mmc/u-boot-dtb.imx >$@
endef

define Build/imx6ull-mtd-full
	mv $@ $@.fw	
	$(call Build/imx6ull-ubootimg)
	dd if=/dev/zero of=$@.new bs=1M count=1
	dd if=$@ of=$@.new conv=notrunc	
	cat $@.fw >>$@.new	
	mv $@.new $@
	rm -f $@.new
endef

define Device/Default
  PROFILES := Generic
  FILESYSTEMS := squashfs ext4
  KERNEL_INSTALL := 1
  KERNEL_SUFFIX := -uImage
  KERNEL_NAME := zImage
  KERNEL_PREFIX := $$(IMAGE_PREFIX)
  KERNEL := kernel-bin | uImage none
endef

define Device/imx6ull-ebf6ull-mmc
  PROFILES := imx6ull-ebf6ull-mmc
  DEVICE_TITLE := EBF6ULL Mini EMMC/SD
  DEVICE_DTS := imx6ull-ebf6ull-mmc
  IMAGES := sysupgrade.bin ebf6ull.img.gz
  IMAGE/ebf6ull.img.gz := append-rootfs | pad-extra 128k | ebf6ull-img
  IMAGE/sysupgrade.bin := sysupgrade-tar
  BOOT_SCRIPT := bootscript-ebf6ull
  DEVICE_PACKAGES := \
  kmod-usb2 kmod-usb3 kmod-usb-ohci kmod-usb-uhci \
  kmod-usb-wdm kmod-usb-core kmod-usb-hid kmod-usb-net \
  kmod-usb-net-cdc-ether kmod-usb-net-cdc-mbim kmod-usb-net-cdc-subset
endef
TARGET_DEVICES += imx6ull-ebf6ull-mmc

$(eval $(call BuildImage))
