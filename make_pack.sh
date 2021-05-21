#!/bin/sh
#menu.sh

DEVICE_DIR='bin/targets/rockchip/armv8/'

echo "---------------------------------------------------------"
echo "please enter your choise device number:"
echo "[0] Exit Menu"
echo "[1] DoorNet1"
echo "[2] DoorNet2"
# echo "[3] IMX6ULL"
# echo "[4] IMX6ULL"
# echo "[5] IMX6ULL"
echo "---------------------------------------------------------"
read input

case $input in
    0)
        exit;;
    1)
        DEVICE_NAME=DoorNet1
        OUTPUT_DIR=EmbedFire_DoorNet1/
        device_name=embedfire_doornet1
        ;;
    2)
        DEVICE_NAME=DoorNet2
        OUTPUT_DIR=EmbedFire_DoorNet2/
        device_name=embedfire_doornet2
        ;;
    # 3)
        # DEVICE_NAME=IMX6ULL
        # OUTPUT_DIR=EmbedFire_Imx6ull
    *)
        echo 'input device number error, exit !'
        exit;;
esac


echo '**********************config set info *********************'
echo 'DEVICE_NAME=' $DEVICE_NAME
echo 'DEVICE_DIR =' $DEVICE_DIR
echo 'OUTPUT_DIR =' $OUTPUT_DIR
echo 'Package file path : '${DEVICE_DIR}${OUTPUT_DIR}


dirdate=`date '+%Y_%m_%d'`
namedate=`date '+%Y%m%d'`

mkdir -p ${DEVICE_DIR}${OUTPUT_DIR}${dirdate}

cp ${DEVICE_DIR}openwrt-rockchip-armv8-${device_name}-ext4-sysupgrade.img.gz ${DEVICE_DIR}${OUTPUT_DIR}${dirdate}/openwrt-${device_name}-ext4-${namedate}.img.gz
cp ${DEVICE_DIR}openwrt-rockchip-armv8-${device_name}-squashfs-sysupgrade.img.gz ${DEVICE_DIR}${OUTPUT_DIR}${dirdate}/openwrt-${device_name}-squashfs-${namedate}.img.gz
cp ${DEVICE_DIR}openwrt-rockchip-armv8-${device_name}.manifest ${DEVICE_DIR}${OUTPUT_DIR}${dirdate}/openwrt-${device_name}.manifest

rm -f ${DEVICE_DIR}${OUTPUT_DIR}${dirdate}/sha256sum
cd ${DEVICE_DIR}${OUTPUT_DIR}
sha256sum ${dirdate}/* > ${dirdate}/sha256sum

