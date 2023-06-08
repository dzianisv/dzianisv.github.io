A short note on how I built OpenWrt + LTE router setup

## Router Unielec U7628-1

[Aliexpress ~40$](https://aliexpress.ru/item/32816981605.html?spm=a2g2w.orderdetail.0.0.7e564aa6qb7B3v&sku_id=64789943590)


![](OpenWrt-LTE-Router-Setup.md-images/2023-06-08-08-37-13.jpg)
![](OpenWrt-LTE-Router-Setup.md-images/2023-06-08-08-37-21.jpg)


> MediaTek MT7628AN ; CPU 580MHz
128MB DDR2
16MB FLASH
PCIE
5x100 Мбит/с 4 * LAN + 1 * WAN (Авто MDI-X)

[Openwrt Wiki](https://openwrt.org/toh/unielec/u7628-01)

## 3G/LTE Module BM806U-C1+

[Aliexpress ~17$](https://aliexpress.ru/item/1005003907236172.html?spm=a2g2w.orderdetail.0.0.3a924aa6hLWSfd&sku_id=12000027436374057)

> 150Mbps FDD-LTE TDD-LTE HSPA/UMTS GSM/GPRS/EDGE
![](OpenWrt-LTE-Router-Setup.md-images/2023-06-08-08-31-23.jpg)


## OpenWrt Configuration

1. `ssh` to the router, install dependencies, configure TTL modificatoin (in case provider track it)

```sh
opkg install kmod-usb-net-cdc-ether usb-modeswitch luci-proto-3g comgt kmod-usb-serial kmod-usb-serial-option kmod-usb-serial-wwan chat
echo "nft add rule inet fw4 mangle_forward ip ttl set 65" >> /etc/firewall.user
echo "net.ipv4.ip_default_ttl=65" > /etc/sysctl.d/99-ttl.conf
echo -e "config include\n\toption path '/etc/firewall.user'\n\toption fw4_compatible '1'" >> /etc/config/firewall
```

2. Configure PPP 3G interface in LUCI->Interfaces