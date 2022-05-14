# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=arm-trusted-firmware-rockchip-vendor
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL=https://github.com/Caesar-github/rkbin.git
PKG_SOURCE_DATE:=2022-04-25
PKG_SOURCE_VERSION:=814f23f5e9361011ced2cc3a3ee2eca5c613af04
PKG_MIRROR_HASH:=3d1d85870728dd40a480e3e3fdb567bd989823a829af4a1a7e7e9bd4b03eee1b

MAKE_PATH:=$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/arm-trusted-firmware-rockchip-vendor
    SECTION:=boot
    CATEGORY:=Boot Loaders
    TITLE:=ARM Trusted Firmware for Rockchip
endef

define Package/arm-trusted-firmware-rk3328
    $(Package/arm-trusted-firmware-rockchip-vendor)
    DEPENDS:=@TARGET_rockchip_armv8
    VARIANT:=rk3328
endef

define Package/arm-trusted-firmware-rk3399
    $(Package/arm-trusted-firmware-rockchip-vendor)
    DEPENDS:=@TARGET_rockchip_armv8
    VARIANT:=rk3399
endef

define Build/Configure
	$(SED) 's,$$$$(PKG_BUILD_DIR),$(PKG_BUILD_DIR),g' $(PKG_BUILD_DIR)/trust.ini
	$(SED) 's,$$$$(VARIANT),$(BUILD_VARIANT),g' $(PKG_BUILD_DIR)/trust.ini
	$(call Build/Configure/Default)
endef

define Build/Compile
	$(CURDIR)/pack-firmware.sh build $(BUILD_VARIANT) '$(PKG_BUILD_DIR)'
endef

define Build/InstallDev
	$(CURDIR)/pack-firmware.sh install $(BUILD_VARIANT) '$(PKG_BUILD_DIR)' '$(STAGING_DIR_IMAGE)'
endef

define Package/arm-trusted-firmware-rk3328/install
endef

define Package/arm-trusted-firmware-rk3399/install
endef

$(eval $(call BuildPackage,arm-trusted-firmware-rk3328))
$(eval $(call BuildPackage,arm-trusted-firmware-rk3399))
