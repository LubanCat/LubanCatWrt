### 欢迎参与LubanCatWrt项目

LubanCatWRT项目是 野火科技 鲁班猫系列开源板卡的配套项目，以官方OpenWrt源码为基础，添加了一些优质的第三方软件包，同时着重对鲁班猫系列板卡进行适配支持和优化，以便玩家们可以更轻松，更高质量的玩转鲁班猫系列板卡。

我们在秉承着**开源共享，共同进步**的理念，希望广大的开发者和玩家参与到我们的项目中来，与我们互动交流，共同进步。

#### 本项目交流群组

- Twitter：https://twitter.com/luban_cat
- Telegram：https://t.me/LubanCatWrt
- 鲁班猫DoorNet系列用户手册：https://doc.embedfire.com/openwrt/user_manal/zh/latest/index.html

#### 联系方式

- 官网： [http://www.embedfire.com](http://www.embedfire.com/)
- 论坛： [http://www.firebbs.cn](http://www.firebbs.cn/)
- github主页：https://github.com/LubanCat
- gitee主页： https://gitee.com/LubanCat
- 淘宝： [https://yehuosm.tmall.com](https://yehuosm.tmall.com/)
- 邮箱： [embedfire@embedfire.com](mailto:embedfire@embedfire.com)
- 电话： 0769-33894118

### 注意事项

- 默认登录IP：192.168.1.1 	密码：admin
- 默认WIFI名 DoorNet-radioX    密码：password （仅WiFi版本）

### 编译命令

1. 使用Linux系统进行编译，推荐Ubuntu LTS

2. 安装编译依赖

   ```shell
   sudo apt-get update
   sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext \
   git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 \
   libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full \
   msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf \
   automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget \
   curl swig rsync aria2
   ```

3. 使用git拉取源码

   ```shell
   # 进入用户目录
   cd

   # 拉取源码
   git clone https://github.com/LubanCat/LubanCatWrt.git

   # 进入拉取的源码目录下
   cd LubanCatWrt

   # 输入板卡对应的数字，更新feeds并下载软件包源码,应用所选板卡的配置文件
   ./make_update.sh

   注意：如果Download下载失败，请安装Aria2，执行命令下载 sudo apt install aria2

   # 在板卡默认配置文件的基础上，添加自定义配置
   make menuconfig

   # 首次编译建议使用单线程编译（-j后面是编译线程数）
   make V=s -j1

   # 非首次编译（可指定线程数，$(nproc)：火力全开）
   make V=s -j$(nproc)
   ```

4. 生成的固件路径：bin/targets/rockchip/armv8
