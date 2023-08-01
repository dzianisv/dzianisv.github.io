
```sh
adb reboot bootloader && while fastboot flashing unlock; do echo Retrying in 5s; sleep 5s; done;
```

You have to see somtheing like this
```
OKAY [  0.020s]
Finished. Total time: 0.020s
```

Then choose "Unlock bootloader using "Volume Down" -> "Power on" button.
Phone will restart and boot to fastboot mode again.
After this the status of the bootloader will be changed:
"Device state: unlocked"


## Flash a new bootloader

```sh
fastboot flash boot boot.img
```

## Flash LineageOS
```sh
adb sideload lineage-19.1-20230425-nightly-blueline-signed.zip 
```
```
Total xfer: 1.00x 
```