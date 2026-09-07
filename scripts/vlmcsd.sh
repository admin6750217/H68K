#!/bin/bash

echo "开始替换 feeds中的vlmcsd ..."
echo "========================================"

rm -rf openwrt/feeds/packages/net/vlmcsd
cp -r patches/vlmcsd openwrt/feeds/packages/net/

echo "===== 查看vlmcsd文件夹是否存在 ====="
ls -l openwrt/feeds/packages/net/ | grep vlmcsd

# 额外验证Makefile是否存在（核心文件）
if [ -f "openwrt/feeds/packages/net/vlmcsd/Makefile" ]; then
  echo "✅ vlmcsd目录替换成功，Makefile存在"
else
  echo "❌ vlmcsd目录替换失败，Makefile不存在"
fi

echo "========================================"
echo "vlmcsd 替换完成！"
