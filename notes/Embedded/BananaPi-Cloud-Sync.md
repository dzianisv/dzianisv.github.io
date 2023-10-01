# Armbian Mega Cloud Syncing server

```bash
wget https://mega.nz/linux/repo/Raspbian_11/armhf/megacmd-Raspbian_11_armhf.deb && sudo apt install -yq "$PWD/megacmd-Raspbian_11_armhf.deb"
```

```shell
mega-login $EMAIL $PASSWORD
mega-sync /data/Documents /Documents
```

To list synchronizations
```shell
mega-sync
```

To remove disable synchronization
```shell
mega-sync -d hRWyR9yQk7I
```



Go to datadog.com and create a free account
and install IoT agent on Armbian

```shell
DD_API_KEY=<> DD_AGENT_FLAVOR='datadog-iot-agent'  DD_SITE="us5.datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
systemctl enable --now datadog-agent
 ```


## Files Synchronization from the localhost
```shell
alias rsync-chacha='rsync -r -t l --progress=status -e "ssh -o Ciphers=chacha20-poly1305@openssh.com"
```
