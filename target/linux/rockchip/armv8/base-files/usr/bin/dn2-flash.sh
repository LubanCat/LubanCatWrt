#!/bin/bash

echo "挂载保存镜像的分区"
mount /dev/mmcblk1p3 /mnt/

if [ -e /dev/mmcblk0p2 ]; then
    echo "1.删除原有分区"
    #1.删除原有分区
    fdisk /dev/mmcblk0 <<EOF
    p
    d

    d

    d
    p
    w
EOF
    echo "即将重启"
    reboot

else
    #3.烧写镜像
    echo "2.烧写镜像，"
    if [ -e /mnt/update.img ]; then
        dd if=/mnt/update.img of=/dev/mmcblk0 bs=1M
        rm -rf /mnt/update-ing
    else
        echo "update.img不存在，请检查"
    fi
    #4.扩容rootfs
    echo "3.扩容rootfs"
    PART_START=$(fdisk -l | grep /dev/mmcblk0p2 | awk '{print $2}')
    fdisk /dev/mmcblk0 <<EOF
    p
    d
    2
    n
    p
    2
    $PART_START

    p
    w
EOF

    echo "4.扩展文件系统"
    resize2fs -p /dev/mmcblk0p2
    #5.同步
    echo "5.烧写镜像完成，等待系统状态灯熄灭后移除电源和SD卡"
    sync
    poweroff
fi
