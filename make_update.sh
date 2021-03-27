#!/bin/sh

echo '**************beginning update and install feeds***********'
#更新升级软件包列表
./scripts/feeds update -a
./scripts/feeds install -a


echo '**************application DoorNet1 defconfig***************'
#使用DoorNet1默认配置
cat defconfig > .config
make defconfig

echo '**************download all packages***********************'
#下载软件包
make download V=s

###如果自己在menuconfig中修改了配置，
###使用#把使用默认配置的命令注释掉再执行此脚本可一键更新软件包

