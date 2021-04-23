#
# Copyright (C) 2013-2016 OpenWrt.org
# Copyright (C) 2016 Yousong Zhou
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

KERNEL_LOADADDR:=0x85000000
CONFIG_TARGET_KERNEL_PARTSIZE=16
	FAT32_BLOCKS=$(shell echo $$(($(CONFIG_TARGET_KERNEL_PARTSIZE)*1024)))

define Build/ebf6ull-sdimg
	rm -rf $@.kernel

	mkfs.fat $@.kernel -C $(FAT32_BLOCKS)
	mcopy -i $@.kernel $(DTS_DIR)/$(DEVICE_DTS).dtb ::imx6ull-14x14-evk.dtb
	mcopy -i $@.kernel $(KERNEL_BUILD_DIR)/zImage ::zImage
	
	./mx6ull_image.sh \
		$@ \
		$(CONFIG_TARGET_KERNEL_PARTSIZE) \
		$@.kernel \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) \
		$(IMAGE_ROOTFS) \
		$(BIN_DIR)/u-boot-mx6ull_ebf6ull_sdcard/u-boot-dtb.imx

endef

define Build/mfg-tools
	rm -rf $(BIN_DIR)/mfg-tools
	mkdir -p $(BIN_DIR)/mfg-tools

	cp  $(DTS_DIR)/$(DEVICE_DTS).dtb $(BIN_DIR)/mfg-tools
	cp  $(KERNEL_BUILD_DIR)/zImage $(BIN_DIR)/mfg-tools
	cp  $(BIN_DIR)/u-boot-mx6ull_ebf6ull_mmc/u-boot-dtb.imx $(BIN_DIR)/mfg-tools
	cp  $(BIN_DIR)/openwrt-imx6ull-device-imx6ull-ebf6ull-mmc-rootfs.tar.gz $(BIN_DIR)/mfg-tools

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
  DEVICE_TITLE := EBF6ULL Mini EMMC
  DEVICE_DTS := imx6ull-ebf6ull-mmc
  IMAGES := ebf6ull_mmc.zip
  IMAGE/ebf6ull_mmc.zip := mfg-tools
  DEVICE_PACKAGES := \
  kmod-usb2 kmod-usb3 kmod-usb-ohci kmod-usb-uhci \
  kmod-usb-wdm kmod-usb-core kmod-usb-hid kmod-usb-net \
  kmod-usb-net-cdc-ether kmod-usb-net-cdc-mbim kmod-usb-net-cdc-subset
endef
TARGET_DEVICES += imx6ull-ebf6ull-mmc

define Device/imx6ull-ebf6ull-sdcard
  PROFILES := imx6ull-ebf6ull-sdcard
  DEVICE_TITLE := EBF6ULL Mini SD
  DEVICE_DTS := imx6ull-ebf6ull-mmc
  IMAGES := ebf6ull.img.gz
  IMAGE/ebf6ull.img.gz := ebf6ull-sdimg
  DEVICE_PACKAGES := \
  kmod-usb2 kmod-usb3 kmod-usb-ohci kmod-usb-uhci \
  kmod-usb-wdm kmod-usb-core kmod-usb-hid kmod-usb-net \
  kmod-usb-net-cdc-ether kmod-usb-net-cdc-mbim kmod-usb-net-cdc-subset
endef
TARGET_DEVICES += imx6ull-ebf6ull-sdcard

$(eval $(call BuildImage))
