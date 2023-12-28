# OpenWrt-CI 

![Release Date](https://img.shields.io/github/release-date/deplives/OpenWrt-CI?label=Release%20Date&style=flat-square)

自用 x86 软路由 OpenWrt 稳定版固件

UTC 时间每个月末最后一天 18:00 自动编译

## 固件特点

- Kernel: 32 MB; Rootfs: 256 MB
- 替换/新增了某些默认插件
    - 替换默认 ttyd
    - 替换默认 luci-ttyd
    - 替换默认 luci-proto-wireguard
    - 新增 阿里云 DDNS
    - 新增 IPsec VPN
    - 新增 国际互联网
    - 新增 WireGuard
- 修改默认主题为 argon
- 修改默认 NTP 服务器
    - ntp.ntsc.ac.cn 
    - ntp.aliyun.com 
    - cn.ntp.org.cn 
    - pool.ntp.org
- 修改默认时区为 Asia/Shanghai
- 修改默认 LAN IP 为 192.168.50.1
- 首页新增 '代码版本' 和 '编译日期'
- 修改默认 console banner 样式
