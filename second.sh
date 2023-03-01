#!/bin/bash
# https://github.com/deplives/OpenWrt-CI

# Run before feeds install

COMMIT_SHA=$1
BUILD_DATE=$2

if [ -z "$COMMIT_SHA" ]; then
    COMMIT_SHA='Unknown'
fi

if [ -z "$BUILD_DATE" ]; then
    BUILD_DATE=$(date +"%Y-%m-%d")
fi

# Modify default timezone
echo 'Modify default timezone...'
sed -i 's/UTC/Asia\/Shanghai/g' package/base-files/files/bin/config_generate

# Modify default NTP server
echo 'Modify default NTP server...'
sed -i 's/ntp.aliyun.com/ntp.ntsc.ac.cn/g' package/base-files/files/bin/config_generate
sed -i 's/time1.cloud.tencent.com/ntp.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/time.ustc.edu.cn/cn.ntp.org.cn/g' package/base-files/files/bin/config_generate
sed -i 's/cn.pool.ntp.org/pool.ntp.org/g' package/base-files/files/bin/config_generate

# Modify default LAN ip
echo 'Modify default LAN IP...'
sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate

# Modify default theme
echo 'Modify default theme...'
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify default ttyd
# https://github.com/deplives/ttyd
echo 'Modify default ttyd...'
rm -rf feeds/packages/utils/ttyd && git clone https://github.com/deplives/ttyd.git feeds/packages/utils/ttyd

# Modify zzz-default-settings
echo 'Delete `sed -i 's#downloads.openwrt.org#mirrors.cloud.tencent.com/lede#g' /etc/opkg/distfeeds.conf`...'
sed -i '/mirrors.cloud.tencent.com/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/openwrt_luci/d' package/lean/default-settings/files/zzz-default-settings

# Modify admin/status/overview <td id="wan4_i" style="width:16px; text-align:center; padding:3px">
echo 'Modify admin/status/overview <td id="wan4_i" style="width:16px; text-align:center; padding:3px">...'
sed -i 's/<td id="wan4_i" style="width:16px; text-align:center; padding:3px">/<td id="wan4_i" style="width:10%; text-align:center; padding:3px">/g' package/lean/autocore/files/x86/index.htm

# Modify admin/status/overview <td id="wan6_i" style="width:16px; text-align:center; padding:3px">
echo 'Modify admin/status/overview <td id="wan6_i" style="width:16px; text-align:center; padding:3px">...'
sed -i 's/<td id="wan6_i" style="width:16px; text-align:center; padding:3px">/<td id="wan6_i" style="width:10%; text-align:center; padding:3px">/g' package/lean/autocore/files/x86/index.htm

# Modify localtime in Homepage
echo 'Modify localtime in Homepage...'
sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/x86/index.htm

# Add Code Version in Homepage
echo 'Add Code Version in Homepage...'
line_kernel_version=$(grep -n 'Kernel Version' package/lean/autocore/files/x86/index.htm | awk -F ':' '{print $1}')
sed -i "${line_kernel_version}a\                <tr><td width=\"33%\"><%:Code Version%></td><td>${COMMIT_SHA}</td></tr>" package/lean/autocore/files/x86/index.htm

# Add Build Date in Homepage
echo 'Add Build Date in Homepage...'
line_code_version=$(grep -n 'Code Version' package/lean/autocore/files/x86/index.htm | awk -F ':' '{print $1}')
sed -i "${line_code_version}a\                <tr><td width=\"33%\"><%:Build Date%></td><td>${BUILD_DATE}</td></tr>" package/lean/autocore/files/x86/index.htm

# Modify hostname in Homepage
echo 'Modify hostname...'
sed -i 's/${g}'"'"' - '"'"'//g' package/lean/autocore/files/x86/autocore

# Replace openwrt.org in diagnostics with www.baidu.com
echo 'Replace openwrt.org in diagnostics.htm with www.baidu.com...'
sed -i "/exit 0/d" package/lean/default-settings/files/zzz-default-settings
cat <<EOF >>package/lean/default-settings/files/zzz-default-settings
uci set luci.diag.ping=www.baidu.com
uci set luci.diag.route=www.baidu.com
uci set luci.diag.dns=www.baidu.com
uci commit luci

exit 0
EOF

# Modify default banner
echo 'Modify default banner...'
echo "                                                               " >package/base-files/files/etc/banner
echo " ██████╗ ██████╗ ███████╗███╗   ██╗██╗    ██╗██████╗ ████████╗ " >>package/base-files/files/etc/banner
echo "██╔═══██╗██╔══██╗██╔════╝████╗  ██║██║    ██║██╔══██╗╚══██╔══╝ " >>package/base-files/files/etc/banner
echo "██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║ █╗ ██║██████╔╝   ██║    " >>package/base-files/files/etc/banner
echo "██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║███╗██║██╔══██╗   ██║    " >>package/base-files/files/etc/banner
echo "╚██████╔╝██║     ███████╗██║ ╚████║╚███╔███╔╝██║  ██║   ██║    " >>package/base-files/files/etc/banner
echo " ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝    " >>package/base-files/files/etc/banner
echo " ------------------------------------------------------------- " >>package/base-files/files/etc/banner
echo " %D %C ${BUILD_DATE} Stable @Bobby                             " >>package/base-files/files/etc/banner
echo " $COMMIT_SHA                                                   " >>package/base-files/files/etc/banner
echo " ------------------------------------------------------------- " >>package/base-files/files/etc/banner
echo "                                                               " >>package/base-files/files/etc/banner
