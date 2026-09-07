#!/bin/bash
set -e

cd /workdir/openwrt

# 使用编译仓库自己的 feeds.conf
cp "$GITHUB_WORKSPACE/feeds.conf" ./feeds.conf

# 清理旧 feeds，避免软件包版本残留
rm -rf feeds package/feeds

echo "===== 使用的 feeds.conf ====="
cat feeds.conf




mkdir -p files/etc/sysctl.d

cat > files/etc/sysctl.d/99-conntrack.conf <<'EOF'
net.netfilter.nf_conntrack_max=655000
EOF
