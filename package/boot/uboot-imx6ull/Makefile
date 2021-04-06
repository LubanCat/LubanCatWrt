include $(TOPDIR)/rules.mk

PKG_NAME:=uboot-imx6ull
PKG_SOURCE_DATE:=2018-09
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/SoMLabs/somlabs-uboot-imx.git
PKG_SOURCE_VERSION:=dbe68c464c301ddcd83ca4c09d7bf93baf85ed5e

include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk

define U-Boot/Default
  BUILD_TARGET:=imx6ull
  UBOOT_IMAGE:=u-boot-dtb.imx
endef

define U-Boot/somlabs_visionsom_6ull
  NAME:=NXP ls1012afrdm 64b Dev Board
endef

UBOOT_TARGETS := \
  somlabs_visionsom_6ull

$(eval $(call BuildPackage/U-Boot))
