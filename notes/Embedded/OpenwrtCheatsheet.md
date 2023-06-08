# OpenWRT Cheatsheet

Here I gathered all the comands I use to configure openwrt on my routers

# Upgrade
```sh
wget https://downloads.openwrt.org/snapshots/targets/ipq40xx/chromium/openwrt-ipq40xx-chromium-google_wifi-squashfs-sysupgrade.bin
sysupgrade -v openwrt-ipq40xx-chromium-google_wifi-squashfs-sysupgrade.bin
```

```sh
opkg install kmod-usb-core kmod-usb3 kmod-usb2 kmod-usb-uhci kmod-usb-ohci kmod-usb-storage kmod-usb-ohci-pci kmod-usb2-pci kmod-usb-storage-uas usbutils kmod-fs-exfat kmod-fs-ntfs
```

# Install luci

```
opkg install luci
```

# Install wireguard
```sh
opkg install luci-proto-wireguard luci-app-wireguard wireguard-tools
```

# 3G/LTE/5G

```sh
opkg install kmod-usb-net-cdc-ether usb-modeswitch luci-proto-3g comgt kmod-usb-serial kmod-usb-serial-option kmod-usb-serial-wwan chat
echo "nft add rule inet fw4 mangle_forward ip ttl set 65" >> /etc/firewall.user
echo "net.ipv4.ip_default_ttl=65" > /etc/sysctl.d/99-ttl.conf
echo -e "config include\n\toption path '/etc/firewall.user'\n\toption fw4_compatible '1'" >> /etc/config/firewall
```

Configure network interface
`/etc/config/network`
```
config interface '3g'
	option device '/dev/ttyUSB1'
	option apn 'internet'
	option service 'umts'
	option proto '3g'
	option ipv6 'auto'
```

# Enable automount

```sh
cat > ~/configure.sh && sh ~/configure.sh
```

```sh
#!/bin/sh
# Install necessary packages
opkg update
opkg install block-mount kmod-usb-storage-extras kmod-fs-ext4 kmod-fs-vfat kmod-fs-ntfs

# Create a new hotplug script for block devices
cat << 'EOF' > /etc/hotplug.d/block/10-usb-storage
#!/bin/sh
[ "\$ACTION" = "add" ] || exit 0
grep -q "^\$DEVICENAME " /proc/mounts && exit 0
mkdir -p /mnt/"$(basename "\$DEVICENAME")"
mount "\$DEVICENAME" /mnt/"$(basename "\$DEVICENAME")"
EOF
# Make the hotplug script executable
chmod +x /etc/hotplug.d/block/10-usb-storage
```

# VSFTPD



```sh
opkg install vsftpd
```

Configuration file is located in “/etc/vsftpd.conf”
To set the default FTP folder add the following to the config file: “local_root=/mnt/usb1”
To enable PASSIVE mode, add the following to the config file: “pasv_enable=YES”, “pasv_min_port=10090”, and “pasv_max_port=10100”
