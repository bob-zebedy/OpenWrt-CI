# OpenWrt-CI 

![](https://img.shields.io/github/workflow/status/deplives/OpenWrt-CI/OpenWrt%20Schedule?event=repository_dispatch&label=%E8%87%AA%E5%8A%A8%E7%BC%96%E8%AF%91&style=flat-square)

自用 x86 软路由 OpenWrt 稳定版固件

如需测试固件请移步至 https://github.com/deplives/OpenWrt-CI-RC

## 固件特点

- 内核大小 32MB; rootfs大小 256 MB
- 替换/新增了某些默认插件
- 修改默认主题为 argon
- 修改默认 NTP 服务器
    - ntp.ntsc.ac.cn 
    - ntp.aliyun.com 
    - cn.ntp.org.cn 
    - pool.ntp.org
- 修改默认时区为 Asia/Shanghai
- 修改默认 LAN IP 为 192.168.50.1
- 首页新增 '编译版本' 和 '编译日期'
- 修改默认 console banner 样式
- 每月 1 日 00:00(UTC) 自动编译, 其余时间不定时手动触发编译

## 替换插件

- [adbyby](https://github.com/deplives/adbyby)
- [luci-app-adbyby-plus](https://github.com/deplives/luci-app-adbyby-plus)
- [luci-app-turboacc](https://github.com/deplives/luci-app-turboacc)
- [ttyd](https://github.com/deplives/ttyd)
- [luci-app-ttyd](https://github.com/deplives/luci-app-ttyd)

## 新增插件

- [阿里 DDNS](https://github.com/deplives/openwrt-package)
- [IPSec VPN](https://github.com/deplives/openwrt-package)
- [QoS 管理](https://github.com/deplives/openwrt-package)

## 后续计划

- [ ] 新增 自动更新 功能