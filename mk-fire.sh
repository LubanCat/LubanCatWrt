#!/bin/sh
#menu.sh


echo "---------------------------------------------------------"
echo "please enter your choise scripts number:"
echo "请输入要运行脚本的序号:"
echo "[0] Exit Menu"
echo "[1] Update feeds/config/download"
echo "[2] Save Defconfig"
echo "---------------------------------------------------------"
read input

case $input in
    0)
        exit;;
    1)
        SCRIPTS=Update
        ;;
    2)
        SCRIPTS=Defconfig
        ;;
    *)
        echo 'input type number error, exit !'
        exit;;
esac

if [ $SCRIPTS = Update ] 
then
    echo '**************begining update and install feeds************'
    #更新升级软件包列表
    ./scripts/feeds update -a
    ./scripts/feeds install -a


    echo '**************application lubancat_defconfig ***************'
    #生成默认配置文件
    cat ./config/lubancat_defconfig > .config
    make defconfig


    echo '**************download all packages***********************'
    #下载软件包
    make download V=s

    ##如果自己在menuconfig中修改了配置，
    ##使用#把使用默认配置的命令注释掉再执行此脚本可一键更新软件包
fi



if [ $SCRIPTS = Defconfig ] 
then
    echo '**************begining write lubancat_defconfig************'
    #写入默认配置文件
    ./scripts/diffconfig.sh > config/lubancat_defconfig

    cat config/lubancat_defconfig

    echo '**********************write successful *********************'
fi
