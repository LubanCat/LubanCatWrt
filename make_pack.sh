#!/bin/sh

dirdate=`date '+%Y_%m_%d'`
namedate=`date '+%Y%m%d'`

mkdir -p ./bin/${dirdate}

cp ./bin/targets/rockchip/armv8/openwrt-rockchip-armv8-embedfire_doornet1-ext4-sysupgrade.img.gz ./bin/${dirdate}/openwrt-embedfire_doornet1-ext4-${namedate}.img.gz
cp ./bin/targets/rockchip/armv8/openwrt-rockchip-armv8-embedfire_doornet1-squashfs-sysupgrade.img.gz ./bin/${dirdate}/openwrt-embedfire_doornet1-squashfs-${namedate}.img.gz
cp ./bin/targets/rockchip/armv8/openwrt-rockchip-armv8-embedfire_doornet1.manifest ./bin/${dirdate}/openwrt-embedfire_doornet1.manifest

rm -f ./bin/${dirdate}/sha256sum
sha256sum ./bin/${dirdate}/* > ./bin/${dirdate}/sha256sum

