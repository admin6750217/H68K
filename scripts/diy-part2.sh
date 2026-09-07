#!/bin/bash
set -e

cd /workdir/openwrt

echo "===== DIY Part2 ====="

# =========================================================
# 删除 feeds 中与第三方插件冲突的版本
# =========================================================

rm -rf ./feeds/packages/net/{geoview,chinadns-ng,hysteria,mosdns,v2ray-geodata,lucky}
rm -rf ./feeds/packages/net/{shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev}
rm -rf ./feeds/packages/net/{sing-box,v2ray-geodata,v2ray-plugin,xray-core,smartdns}

rm -rf ./feeds/luci/applications/{luci-app-passwall,luci-app-passwall2,luci-app-openclash,luci-app-homeproxy}
rm -rf ./feeds/luci/applications/{luci-app-lucky,luci-app-smartdns,luci-app-timecontrol,luci-app-mosdns}
rm -rf ./feeds/luci/applications/{luci-app-nikki,luci-app-momo,luci-app-daed}

# =========================================================
# PassWall 依赖
# =========================================================

rm -rf package/pwpage

git clone \
  --depth 1 \
  https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git \
  package/pwpage

# =========================================================
# 第三方插件
# =========================================================

mkdir -p package/small
pushd package/small

# Aurora 主题
git clone \
  -b master \
  --depth 1 \
  https://github.com/eamonxg/luci-theme-aurora.git

# TimeControl
git clone \
  -b main \
  --depth 1 \
  https://github.com/sirpdboy/luci-app-timecontrol.git

# HomeProxy
git clone \
  -b master \
  --depth 1 \
  https://github.com/immortalwrt/homeproxy.git

# Lucky
git clone \
  -b main \
  --depth 1 \
  https://github.com/gdy666/luci-app-lucky.git

# SmartDNS LuCI
git clone \
  -b master \
  --depth 1 \
  https://github.com/pymumu/luci-app-smartdns.git

# SmartDNS
git clone \
  -b master \
  --depth 1 \
  https://github.com/pymumu/smartdns.git

sed -i \
  's@include ../../lang/rust/rust-package.mk@include $(TOPDIR)/feeds/packages/lang/rust/rust-package.mk@g' \
  smartdns/package/openwrt/Makefile

echo "===== SmartDNS Rust Makefile ====="
sed -n '33p' smartdns/package/openwrt/Makefile

# VIKINGYFY packages
git clone \
  -b main \
  --depth 1 \
  https://github.com/VIKINGYFY/packages.git

# PassWall
git clone \
  -b main \
  --depth 1 \
  https://github.com/Openwrt-Passwall/openwrt-passwall.git

# PassWall2
git clone \
  -b main \
  --depth 1 \
  https://github.com/Openwrt-Passwall/openwrt-passwall2.git

# MosDNS
git clone \
  -b v5 \
  --depth 1 \
  https://github.com/sbwml/luci-app-mosdns.git

# =========================================================
# Netspeedtest
# 暂时禁用：当前仓库 clone 时出现 GitHub 认证错误
# =========================================================

# git clone \
#   -b master \
#   --depth 1 \
#   https://github.com/sirpdboy/luci-app-netspeedtest.git

# OpenClash
git clone \
  -b master \
  --depth 1 \
  https://github.com/vernesong/OpenClash.git

# Nikki
git clone \
  -b main \
  --depth 1 \
  https://github.com/nikkinikki-org/OpenWrt-nikki.git

# Momo
git clone \
  -b main \
  --depth 1 \
  https://github.com/nikkinikki-org/OpenWrt-momo.git

# Daed
git clone \
  -b master \
  --depth 1 \
  https://github.com/QiuSimons/luci-app-daed.git

popd

echo "========================================"
echo "DIY Part2 插件源码下载完成"
echo "========================================"
