#!/bin/bash
# https://github.com/deplives/OpenWrt-CI

# Uncomment a feed source
# echo 'Uncomment helloworld feed...'
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

echo 'Replace https://github.com/coolsnowwolf/packages'
sed -i 's/https:\/\/github.com\/coolsnowwolf\/packages/https:\/\/github.com\/deplives\/packages/g' feeds.conf.default

echo 'Replace https://github.com/coolsnowwolf/luci'
sed -i 's/https:\/\/github.com\/coolsnowwolf\/luci/https:\/\/github.com\/deplives\/luci/g' feeds.conf.default

echo 'Add helloworld feed...'
sed -i '$a src-git helloworld https://github.com/deplives/helloworld' feeds.conf.default

echo 'Add openwrt-package feed...'
sed -i '$a src-git bobby https://github.com/deplives/openwrt-package' feeds.conf.default
