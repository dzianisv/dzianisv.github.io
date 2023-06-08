# Short Guide: Automount USB storage on Armbian

Here's a simple systemd service file that should do what you're looking for:
```
[Unit]
Description=External5TB Mount Service

[Service]
ExecStart=/bin/bash -c 'while :; do mount -o uid=$(id -u rslsync),gid=$(id -g rslsync) /dev/disk/by-label/External5TB /data/; sleep 10s; done;'
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Save this file as `/etc/systemd/system/external5tb-mount.service`, and then run the following commands to enable and start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable external5tb-mount.service
sudo systemctl start external5tb-mount.service
```

This will start the service and automatically mount the External5TB drive with the specified permissions every 10 seconds in the background.