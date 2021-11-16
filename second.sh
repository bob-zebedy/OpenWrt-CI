#!/bin/bash
# https://github.com/deplives/OpenWrt-CI

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
