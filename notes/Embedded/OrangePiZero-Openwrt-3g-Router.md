# Short Guide: How to create a travel 3G/LTE/5G router on OrangePi Zero.

1. Download and flash OpenWRT image to the SD Card: https://openwrt.org/toh/hwdata/xunlong/xunlong_orange_pi_zero.
2. Insert the SD Card into the board. Power on. Connect to the ethernet port. By default there is a DHCP server running on the LAN port, so your PC has to get the IP address from 192.168.1.0/24
2. Open http://192.168.1.1, use root as a login and empty password to log in into the admin web console.
3. Change the IP address of the LAN network interface to something that doesn't conflict with your current local network configuration, like 192.168.255/1.
4. Connect the OrangePi Zero to the you local network router.
5. Connect the laptop to you home local network.
6. Add a 192.168.255.2/24 on yours laptop network interface. On macOS run `sudo ifconfig en0 alias 192.168.255.2/24` on Linux `sudo ip a a 192.168.255.2/24 dev wlp2s0`.
7. `ssh root@192.168.255.1`
```sh
ip addr add 192.168.1.128/24 dev br-lan
ip route add default <gateway> via br-lan
echo nameserver 192.168.1.1 > /etc/resolv.conf
```
10. Install package that are required for USB 3g dongle, configure firewall to chage TTL
```sh
opkg update
opkg install kmod-usb-net-cdc-ether usb-modeswitch luci-proto-wireguard luci-app-wireguard wireguard-tools

# it reuiqred in case if ISP blocks Internet-sarhing ;)
echo  net.ipv4.ip_default_ttl=65 > /etc/sysctl.d/99-ttl.conf
echo -e "config include\n\toption path '/etc/firewall.user'\n\toption fw4_compatible '1'" >> /etc/config/firewall
echo -e "nft add rule inet fw4 mangle_forward oifname eth1 ip ttl set 65" >> '/etc/firewall.user'
/etc/init.d/firewall restart
```

/etc/rc.local
```
nft add rule inet fw4 mangle_forward oifname eth1 ip ttl set 65
ip route add default via 10.0.42.1 table vlan2
iperf -s -D
/etc/init.d/healthcheck
```
