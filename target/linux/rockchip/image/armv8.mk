# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2020 Sarah Maedel

# FIT will be loaded at 0x02080000. Leave 16M for that, align it to 2M and load the kernel after it.
KERNEL_LOADADDR := 0x03200000

define Device/embedfire_lubancat-zero-n
  DEVICE_VENDOR := EmbedFire
  DEVICE_MODEL := LubanCat-Zero-N
  SOC := rk3566
  UBOOT_DEVICE_NAME := lubancat-zero-n-rk3566
  DEVICE_PACKAGES := kmod-mt7921e wpad-openssl luci-app-modem
endef
TARGET_DEVICES += embedfire_lubancat-zero-n

define Device/embedfire_lubancat-1
  DEVICE_VENDOR := EmbedFire
  DEVICE_MODEL := LubanCat-1
  SOC := rk3566
  UBOOT_DEVICE_NAME := lubancat-1-rk3566
  DEVICE_PACKAGES := kmod-mt7921e wpad-openssl luci-app-modem
endef
TARGET_DEVICES += embedfire_lubancat-1

define Device/embedfire_lubancat-1n
  DEVICE_VENDOR := EmbedFire
  DEVICE_MODEL := LubanCat-1N
  SOC := rk3566
  DEVICE_PACKAGES := kmod-r8169 -urngd kmod-ata-ahci
endef
TARGET_DEVICES += embedfire_lubancat-1n

define Device/embedfire_lubancat-2
  DEVICE_VENDOR := EmbedFire
  DEVICE_MODEL := LubanCat-2
  SOC := rk3568
  UBOOT_DEVICE_NAME := lubancat-2-rk3568
  DEVICE_PACKAGES := kmod-r8169 -urngd kmod-ata-ahci
endef
TARGET_DEVICES += embedfire_lubancat-2

define Device/embedfire_lubancat-2n
  DEVICE_VENDOR := EmbedFire
  DEVICE_MODEL := LubanCat-2N
  SOC := rk3568
  UBOOT_DEVICE_NAME := lubancat-2n-rk3568
  DEVICE_PACKAGES := kmod-r8169 -urngd kmod-ata-ahci
endef
TARGET_DEVICES += embedfire_lubancat-2n

define Device/embedfire_lubancat-2io
  DEVICE_VENDOR := EmbedFire
  DEVICE_MODEL := LubanCat-2IO
  SOC := rk3568
  UBOOT_DEVICE_NAME := lubancat-2n-rk3568
  DEVICE_PACKAGES := kmod-r8169 -urngd kmod-ata-ahci
endef
TARGET_DEVICES += embedfire_lubancat-2io
