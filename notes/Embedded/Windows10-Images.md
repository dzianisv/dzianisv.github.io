👨‍💻 Reinstalling Windows - the bittersweet pain of PC ownership! It's the one task that every computer user dreads. And yet, when I visit my parents, it's a task that I am often called upon to do with alarming frequency. It seems like every time I arrive, there's a different PC in need of some TLC. Malware, viruses, registry issues, HDD replacements - all contributing to slow and sluggish performance. 

As a software engineer, I knew there had to be a more efficient way of dealing with this. And so, I turned to disk images. I tried a number of different solutions for disk cloning, but surprisingly, the best tool for the job turned out to be good old UNIX 'dd'. Who would have thought?!

Here's how I make it happen:

1. I detach the SSD from the PC in question and connect it to my trusty MacBook.

2. Using qemu, I install Windows 10 from an ISO image. Pro tip - this works on Linux too! 
```bash
#!/bin/bash

DISK=${1:-disk.img}
ISO=${2:-}

if ! command -v qemu-system-x86_64 2> /dev/null; then
  brew install qemu
fi


for d in ${DISK}*; do
  diskutil unmount "$d"
done

exec qemu-system-x86_64 \
  -m 8096 \
  -usb \
  -device usb-tablet \
  -monitor stdio \
  -device intel-hda \
  -machine type=q35,accel=hvf \
  -cpu Haswell \
  -hda "$DISK" \
  -boot d -cdrom $ISO"
```
Just remember - for Linux users, you'll need to change `accel=hvf` to `kvm`.

3. Install all the necessary software. I like to use Chocolatey (like `apt-get` or `brew` but for Windows) to bulk install basic essentials like Opera (my parents' fave), Telegram, and mpv (a lightweight and powerful video player). 
    Pro tip: To install it, just run
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
4. Attach the disk. I use a trusty USB-SATA adapter, but don't forget to check `diskutility` to see what the device file is for the attached disk. It could be something like `/dev/disk2` (on a Mac).

5. Time to flash the disk with the image. I use the good old `dd` command again (but don't worry, it's not as scary as it looks):
```bash
sudo dd if=disk.img of=${DIS} bs=1M status=progress
```
If you prefer, you can also use [Etcher](https://etcher.balena.io/), which makes flashing images to flash/HDD/SSD a breeze.

6. Finally, I compress the image and store it on the family NAS for next time duty calls:
```bash
bzip -9 disk.img
```

And that's it! With these simple steps, I now have a reliable and efficient way to reinstall Windows on multiple PCs without the hassle of doing everything manually. Maybe someday I'll convince my parents to switch to Linux...but until then, we'll keep on reinstalling.
