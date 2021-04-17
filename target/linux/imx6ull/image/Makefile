#
# Copyright (C) 2013-2016 OpenWrt.org
# Copyright (C) 2016 Yousong Zhou
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

FAT32_BLOCK_SIZE=1024
SD_BOOT_PARTSIZE=40
FAT32_BLOCKS=$(shell echo $$(($(SD_BOOT_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

KERNEL_LOADADDR:=0x85000000

define Build/sunxi-sdcard
	rm -f $@.boot
	mkfs.fat $@.boot -C $(FAT32_BLOCKS)

	mcopy -i $@.boot $(DTS_DIR)/$(DEVICE_DTS).dtb ::dtb
	mcopy -i $@.boot $(IMAGE_KERNEL) ::uImage
	./gen_sunxi_sdcard_img.sh $@ \
		$@.boot \
		$(IMAGE_ROOTFS) \
		$(SD_BOOT_PARTSIZE) \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) \
		$(BIN_DIR)/u-boot-somlabs_visionsom_6ull/u-boot-dtb.imx
	rm -f $@.boot
endef

define Build/imx6ull-ubootimg
	rm -f $@
	rm -f $@.pad
	dd if=/dev/zero of=$@.pad bs=1024 count=1
	cat $@.pad $(BIN_DIR)/u-boot-somlabs_visionsom_6ull/u-boot-dtb.imx >$@
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
  IMAGES := sysupgrade.bin
  IMAGE/combined.bin := append-rootfs | pad-extra 128k 
  IMAGE/sysupgrade.bin := sysupgrade-tar
  DEVICE_PACKAGES := \
  kmod-usb2 kmod-usb3 kmod-usb-ohci kmod-usb-uhci \
  kmod-usb-wdm kmod-usb-core kmod-usb-hid kmod-usb-net \
  kmod-usb-net-cdc-ether kmod-usb-net-cdc-mbim kmod-usb-net-cdc-subset
endef
TARGET_DEVICES += imx6ull-ebf6ull-mmc

$(eval $(call BuildImage))
