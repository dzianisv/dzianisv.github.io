# OrangePiZeor Files Custodian

## Connect to the OrangePiZero

You can connect orangepizero over Ethernet or UART to get CLI


## Install required tools

```shell
apt update -yq && apt install -yq udisks2 network-manager
systemctl enable --now NetworkManager

if ! command -v avahi-daemon; then
    apt update -yq && apt install -yq avahi-daemon
    curl "https://raw.githubusercontent.com/lathiat/avahi/master/avahi-daemon/ssh.service" > /etc/avahi/services/ssh.service
fi
```

## Connect OrnagePiZero over WiFi

This is trick part, that you need to connect OrangePiZero over Ethernet or UART in order to get CLI access and configurat a wireless access. Probably there is a better way, but I didn't find it yet.

```
nmtui
```

## Install tailscale and add to the same network with the backup device

```shell
if ! tailscale status; then
    curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg" -o /usr/share/keyrings/tailscale-archive-keyring.gpg
    curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list" -o /etc/apt/sources.list.d/tailscale.list
    apt update -yq && apt install -yq tailscale
    tailscale up
fi
```


## Configure a backup script


```shell
curl "https://github.com/dzianisv/utils/blob/master/bin/linux-install-transfer-dcim.sh" | bash
```

This installs a `/usr/local/bin/transfer-dcim` bash script I created to
1. Automount any attached storage (usbdisk, sdcard, camera in file transfer mode)
2. Rsync files to the remote server. Remove servers has to be defined in the $HOME/.config/transfer-dcim-destinations.txt in the following format

```
root@bananapi.local:/media/root/External5TB/Photo
root@bananapi:/media/root/External5TB/Photo
```

I used 2 destinations hostnames for the same host in order to try a direct connect first. `bananapi.local` is a broadcasted by the `avahi-daemon` mDNS name.
If the OrangePI is able to connect using this name, it will be connected directly over the local network, in this case a best trougput is  available.

Otherwise, a tailscale-defined hostname `banaanpi` is used. Tailscale encryption + rsync over ssh encryption load CPU twice, so it will transfer files slower. But in this case it will be transfered from any point on the world where you can conect orangepizero to the Internet.
3. Delete files from the attached storage when backup is done

## Authorize OrangePiZero to connect to the backup server

You need to put generate ssh keys and add this key to the remote backup server in order to authorize OrangePiZero to rsync files to it. In my case root@bananapi.local is the hostname


```shell
ssh-keygen -t ed25519
ssh-copy-id root@bananapi.local
```

## Fun

Now you can connect your camera to the OrangePiZero or Connect SD card using USB-SDCard reader and it will move all the files from attached storage to the remote host.


## TODO

1. Add led to indicate that backup in process or finished.
2. Add smal display and a few buttons or voice interface to connect to the WiFi.
