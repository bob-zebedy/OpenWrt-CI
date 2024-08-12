#!/bin/bash
# https://github.com/bob-zebedy/OpenWrt-CI

# Run after feeds install

# Delete dns query in page connections
echo 'Delete dns query in page connections...'
if [ $(grep -c 'admin/status/nameinfo' package/feeds/luci/luci-mod-admin-full/luasrc/view/admin_status/connections.htm) -ne '0' ]; then
    start_line=$(grep -n 'if (lookup_queue.length > 0)' package/feeds/luci/luci-mod-admin-full/luasrc/view/admin_status/connections.htm | awk -F : '{printf $1}')
    end_line=$(grep -n 'var data = json.statistics;' package/feeds/luci/luci-mod-admin-full/luasrc/view/admin_status/connections.htm | awk -F : '{printf $1 - 1}')
    sed -i "${start_line},${end_line}d" package/feeds/luci/luci-mod-admin-full/luasrc/view/admin_status/connections.htm
fi

# Delete placeholder in dhcp.lua
echo 'Delete bogusnxdomain placeholder...'
sed -i '/67.215.65.132/d' feeds/luci/modules/luci-mod-admin-full/luasrc/model/cbi/admin_network/dhcp.lua

echo 'Delete dns server placeholder...'
sed -i '/10.1.2.3/d' feeds/luci/modules/luci-mod-admin-full/luasrc/model/cbi/admin_network/dhcp.lua

echo 'Delete rebind domain placeholder...'
sed -i '/ihost.netflix.com/d' feeds/luci/modules/luci-mod-admin-full/luasrc/model/cbi/admin_network/dhcp.lua

echo 'Add i18n in base.po...'
cat <<EOF >>feeds/luci/modules/luci-base/po/zh-cn/base.po

msgid "Build Version"
msgstr "编译版本"

msgid "Build Date"
msgstr "编译日期"

msgid "try"
msgstr "尝试"

msgid "force"
msgstr "强制"

msgid "Do not send a Release when restarting"
msgstr "重启后前缀不释放"

msgid "Enable to minimise the chance of prefix change after a restart"
msgstr "启用以最大限度地减少重启后前缀更改的可能性"

EOF