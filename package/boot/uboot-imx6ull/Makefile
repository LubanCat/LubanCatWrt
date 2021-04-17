include $(TOPDIR)/rules.mk

PKG_VERSION:=2016.03
PKG_RELEASE:=1

PKG_HASH:=e49337262ecac44dbdeac140f2c6ebd1eba345e0162b0464172e7f05583ed7bb

include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk

define U-Boot/Default
  BUILD_TARGET:=imx6ull
  UBOOT_IMAGE:=u-boot.imx
endef

define U-Boot/mx6ull_ebf6ull_nand
  NAME:=EmbedFire EBF6ULL Mini NAND
endef

define U-Boot/mx6ull_ebf6ull_emmc
  NAME:=EmbedFire EBF6ULL Mini EMMC
endef

define U-Boot/mx6ull_ebf6ull_sd
  NAME:=EmbedFire EBF6ULL Mini SD
endef

UBOOT_TARGETS := \
  mx6ull_ebf6ull_nand \
  mx6ull_ebf6ull_emmc \
  mx6ull_ebf6ull_sd 

$(eval $(call BuildPackage/U-Boot))
