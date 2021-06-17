#!/bin/sh
#menu.sh

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
        DEVICE_CFG=doornet1_defconfig
        ;;
    2)
        DEVICE_NAME=DoorNet2
        DEVICE_CFG=doornet2_defconfig
        ;;
    # 3)
        # DEVICE_NAME=IMX6ULL
        # DEVICE_CFG=imx6ull_defconfig
        # sleep 1;;
    *)
        echo 'input device number error, exit !'
        exit;;
esac


echo '**********************config set info *********************'
echo 'DEVICE_NAME=' $DEVICE_NAME
echo 'DEVICE_CFG =' $DEVICE_CFG


echo '**************begining write' ${DEVICE_CFG} '************'
#写入默认配置文件
./scripts/diffconfig.sh > config/${DEVICE_CFG}

cat config/${DEVICE_CFG}

echo '**********************write successful *********************'
