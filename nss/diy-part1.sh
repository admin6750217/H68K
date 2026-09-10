#!/bin/bash
#
# DIY1
# H68K + ImmortalWrt/OpenWrt
#

# ============================================================
# 添加 kenzok8 软件源
# ============================================================

sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default
sed -i '3i src-git smpackage https://github.com/kenzok8/small-package' feeds.conf.default


# ============================================================
# 删除官方冲突包
# ============================================================

rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-passwall2
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-homeproxy
rm -rf feeds/luci/applications/luci-app-lucky
rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-mosdns

rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/sing-box
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/dns2socks
rm -rf feeds/packages/net/hysteria
rm -rf feeds/packages/net/ipt2socks
rm -rf feeds/packages/net/microsocks
rm -rf feeds/packages/net/naiveproxy
rm -rf feeds/packages/net/shadowsocks-rust
rm -rf feeds/packages/net/shadowsocksr-libev
rm -rf feeds/packages/net/simple-obfs
rm -rf feeds/packages/net/tcping
rm -rf feeds/packages/net/v2ray-plugin
rm -rf feeds/packages/net/xray-plugin
rm -rf feeds/packages/net/geoview
rm -rf feeds/packages/net/shadow-tls
rm -rf feeds/packages/net/alist
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/smartdns

rm -rf feeds/packages/utils/v2dat


# ============================================================
# Golang
# ============================================================

rm -rf feeds/packages/lang/golang

git clone --depth 1 -b 1.26 \
https://github.com/kenzok8/golang \
feeds/packages/lang/golang


# ============================================================
# PassWall 依赖
# ============================================================

rm -rf package/passwall-packages

git clone --depth 1 \
https://github.com/Openwrt-Passwall/openwrt-passwall-packages \
package/passwall-packages


# ============================================================
# 更新 feeds
# ============================================================

./scripts/feeds update -a
./scripts/feeds install -a


# ============================================================
# 自动添加 LuCI 中文语言包
# ============================================================

for pkg in $(grep '^CONFIG_PACKAGE_luci-app-.*=y' .config | sed 's/^CONFIG_PACKAGE_//;s/=y//'); do
    trans="luci-i18n-${pkg#luci-app-}"

    if grep -q "^CONFIG_PACKAGE_${trans}-zh-cn=y" .config 2>/dev/null; then
        continue
    fi

    if grep -rq "Package.*${trans}-zh-cn" feeds/luci feeds/*/* 2>/dev/null; then
        echo "自动添加中文语言包: ${trans}-zh-cn"
        echo "CONFIG_PACKAGE_${trans}-zh-cn=y" >> .config
    fi
done


# ============================================================
# 修正配置
# ============================================================

make defconfig
