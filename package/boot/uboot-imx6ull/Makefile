include $(TOPDIR)/rules.mk

PKG_VERSION:=2020.10
PKG_RELEASE:=1

PKG_HASH:=0d481bbdc05c0ee74908ec2f56a6daa53166cc6a78a0e4fac2ac5d025770a622

include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk

define U-Boot/Default
  BUILD_TARGET:=imx6ull
  UBOOT_IMAGE:=u-boot-dtb.imx
endef

define U-Boot/imx6ull-ebf6ull-nand
  NAME:=EmbedFire EBF6ULL Mini NAND
endef

UBOOT_TARGETS := \
  imx6ull-ebf6ull-nand

$(eval $(call BuildPackage/U-Boot))
