#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Add the default password for the 'root' user（Change the empty password to 'password'）
# sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow
# sed -i '/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF./d' package/lean/default-settings/files/zzz-default-settings    # 设置密码为空

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-argon）
# sed -i 's/luci-theme-bootstrap/luci-theme-edge/g' ./feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# Modify wifi default off to on
sed -i "/wireless.\${name}.disabled/d" package/kernel/mac80211/files/lib/wifi/mac80211.sh || sed -i "/wireless.\${name}.disabled/d" package/network/config/wifi-scripts/files/lib/wifi/mac80211.sh

# Add autocore support for armvirt
# sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set DISTRIB_REVISION
# sed -i "s/OpenWrt /OpenWrt Build $(TZ=UTC-8 date "+%Y-%m-%d") Compiled By TSingui /g" package/lean/default-settings/files/zzz-default-settings
# echo "DISTRIB_SOURCECODE='OpenWrt'" >> package/base-files/files/etc/openwrt_release
# Set etc/openwrt_release
# sed -i '/DISTRIB_REVISION/d' package/base-files/files/etc/openwrt_release
# echo "DISTRIB_REVISION='R$(TZ=UTC-8 date +%Y-%m-%d)'" >> package/base-files/files/etc/openwrt_release
# sed -i '/DISTRIB_DESCRIPTION/d' package/base-files/files/etc/openwrt_release
# echo "DISTRIB_DESCRIPTION='OpenWRT R$(TZ=UTC-8 date +%Y-%m-%d) Compiled By TSingui'" >> package/base-files/files/etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(TZ=UTC-8 date +%Y-%m-%d)'|g" package/base-files/files/etc/openwrt_release
sed -i "s|DISTRIB_DESCRIPTION='.*'|DISTRIB_DESCRIPTION='OpenWRT R$(TZ=UTC-8 date +%Y-%m-%d) Compiled By TSingui'|g" package/base-files/files/etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(TZ=UTC-8 date +%Y-%m-%d)'|g" package/emortal/default-settings/files/99-default-settings
sed -i "s|DISTRIB_DESCRIPTION='.*'|DISTRIB_DESCRIPTION='OpenWRT R$(TZ=UTC-8 date +%Y-%m-%d) Compiled By TSingui'|g" package/emortal/default-settings/files/99-default-settings

# Modify default IP（FROM 192.168.1.1 CHANGE TO 10.0.0.1）
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# Modify system hostname（FROM OpenWrt CHANGE TO Tomato）
sed -i 's/OpenWrt/Tomato/g' package/base-files/files/bin/config_generate

# Replace the default software source
# sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template

# Add software
# git clone https://github.com/sbwml/luci-app-alist package/luci-app-alist
# git clone --depth 1 https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
# svn co https://github.com/lisaac/luci-app-diskman/trunk/applications/luci-app-diskman package/luci-app-diskman
# git clone --depth 1 https://github.com/lisaac/luci-app-diskman.git && mv luci-app-diskman/applications/luci-app-diskman package/luci-app-diskman && rm -rf luci-app-diskman
# mkdir -p package/luci-app-diskman && wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/applications/luci-app-diskman/Makefile -O package/luci-app-diskman/Makefile
# mkdir -p package/parted && wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O package/parted/Makefile
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall
# git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
# git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/luci-app-passwall/packages
# git clone --depth 1 https://github.com/messense/aliyundrive-fuse.git && mv aliyundrive-fuse/openwrt/* ./package && rm -rf aliyundrive-fuse
# git clone --depth 1 https://github.com/messense/aliyundrive-webdav.git && mv aliyundrive-webdav/openwrt/* ./package && rm -rf aliyundrive-webdav
# git clone https://github.com/kenzok8/small-package package/small-package
# git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

# luci-theme-argon for openwrt
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
# luci-theme-argon for lede
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# 删除重复包
rm -rf feeds/kiddin9/luci-app-alist
rm -rf feeds/kiddin9/luci-app-aria2
rm -rf feeds/kiddin9/luci-app-transmission
rm -rf feeds/kiddin9/luci-app-docker
rm -rf feeds/kiddin9/luci-app-dockerman
rm -rf feeds/kiddin9/dockerd
rm -rf feeds/kiddin9/firewall
rm -rf feeds/kiddin9/firewall4
rm -rf feeds/kiddin9/luci-app-frpc
rm -rf feeds/kiddin9/luci-app-frps
rm -rf feeds/kiddin9/frp
rm -rf feeds/kiddin9/luci-app-ksmbd
rm -rf feeds/kiddin9/luci-app-samba4
rm -rf feeds/kiddin9/luci-app-nlbwmon
rm -rf feeds/kiddin9/luci-app-wrtbwmon
rm -rf feeds/kiddin9/wrtbwmon
rm -rf feeds/kiddin9/luci-app-rtbwmon
rm -rf feeds/kiddin9/luci-app-upnp
rm -rf feeds/kiddin9/luci-app-cifs
rm -rf feeds/kiddin9/luci-app-bypass
rm -rf feeds/kiddin9/luci-app-chinadns-ng
rm -rf feeds/kiddin9/luci-app-clash
rm -rf feeds/kiddin9/luci-app-mosdns
rm -rf feeds/kiddin9/luci-app-passwall2
rm -rf feeds/kiddin9/luci-app-shadowsocks-libev
rm -rf feeds/kiddin9/luci-app-shadowsocks-rust
rm -rf feeds/kiddin9/luci-app-ssr-libev-server
rm -rf feeds/kiddin9/luci-app-ssr-mudb-server
rm -rf feeds/kiddin9/luci-app-ssr-plus
rm -rf feeds/kiddin9/luci-app-ssrserver-python
rm -rf feeds/kiddin9/luci-app-v2ray-server
rm -rf feeds/kiddin9/luci-app-v2raya
rm -rf feeds/kiddin9/luci-app-tencentcloud-cos
rm -rf feeds/kiddin9/luci-app-tencentddns
rm -rf feeds/kiddin9/luci-app-ddns
rm -rf feeds/kiddin9/ddns-scripts
rm -rf feeds/kiddin9/luci-app-istorex
rm -rf feeds/kiddin9/luci-app-quickstart
rm -rf feeds/kiddin9/quickstart
rm -rf feeds/kiddin9/luci-lib-taskd
rm -rf feeds/kiddin9/luci-app-store
rm -rf feeds/kiddin9/luci-app-ddnsto
rm -rf feeds/kiddin9/ddnsto
rm -rf feeds/kiddin9/luci-app-linkease
rm -rf feeds/kiddin9/linkease
rm -rf feeds/kiddin9/automount
rm -rf feeds/kiddin9/luci-app-LingTiGameAcc
rm -rf feeds/kiddin9/LingTiGameAcc
rm -rf feeds/kiddin9/luci-app-speederv2
rm -rf feeds/kiddin9/luci-app-speedtest-web
rm -rf feeds/kiddin9/speedtest-web
rm -rf feeds/kiddin9/speedtest-go

# rm -rf feeds/luci/themes/luci-theme-argon
# rm -rf feeds/luci/applications/luci-app-argon-config
# rm -rf feeds/luci/applications/luci-app-diskman
# rm -rf package/small-package/luci-app-amlogic
# rm -rf package/small-package/luci-app-argon*
# rm -rf package/small-package/luci-theme-argon*
# rm -rf feeds/luci/applications/luci-app-netdata
# rm -rf package/small-package/luci-app-koolproxyR
# rm -rf package/small-package/luci-app-godproxy
# rm -rf package/small-package/openvpn-easy-rsa-whisky
# rm -rf package/small-package/luci-app-mosdns
# rm -rf package/small-package/luci-app-openvpn-server
# rm -rf package/small-package/luci-app-store
# rm -rf package/small-package/luci-app-istorex
# rm -rf package/small-package/luci-app-quickstart
# rm -rf package/small-package/luci-app-xray
# rm -rf package/small-package/luci-app-wrtbwmon
# rm -rf package/small-package/wrtbwmon

# 其他调整
# sed -i 's#https://github.com/breakings/OpenWrt#https://github.com/tsingui/Actions_OpenWrt-Amlogic#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
# sed -i 's#ARMv8#openwrt_armvirt#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
# sed -i 's#opt/kernel#kernel#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
# sed -i 's#mount -t cifs#mount.cifs#g' feeds/luci/applications/luci-app-cifs-mount/root/etc/init.d/cifs
