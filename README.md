# About Me
Hi, I am a Software Engineer and pacionate about Networking and Decntralized Distributed systems. Here on Github are my notes and projects.

# Blogposts and Notes
- [Development](notes/Development/README.md)
- [Blockchain](notes/blockchain/README.md)
- [Trading Bots](notes/TradingBot/README.md)
- [Networking](notes/Networking/)
- [Embedded](notes/Embedded/README.md)
- [AI](notes/AI/README.md)


# My Open Source Software Projects

## [Plato Voice Assistant](https://github.com/dzianisv/AssistantPlato)

AssistantPlato is an open-source project that offers a versatile and powerful AI personal assistant. Utilizing cutting-edge natural language processing (NLP) techniques, machine learning algorithms, and various APIs, AssistantPlato creates a comprehensive and user-friendly personal assistant experience. The project aims to streamline daily tasks, manage schedules, answer queries, and provide tailored recommendations. Its user-friendly interface and robust feature set make AssistantPlato suitable for a wide range of users, from individuals to businesses, and it can be easily integrated into various platforms for seamless assistance.

## [lxdbox](https://github.com/dzianisv/lxdbox)
LXD containers management tool.

It allows to run desktop applications inside LXD contaier, helpful when you need a few separate work/dev environments on one host machine. Still a way better than Virtual Machine (kvm/virtualbox).
- Create a container with a Guest OS;
- Share a folder with a host OS;
- Proxy Desktop environment from the host OS;
- Proxy Video/Camera devices from the host OS;
- Proxy PulseAudio from the host OS;
- Proxy USB devices, like and Android Phone from the host;
- Enables KVM. Usefult to run Adrnoid Emulator or other VM inside the container;


## [vpngate-client](https://github.com/dzianisv/vpngate-client)
A free open-source OpenVPN service. It discovers a public VPN servers on [vpngate.net](https://vpngate.net), checks health of the server and then connects to it. Healthchecks are perfomed during service work hours. If the OpenVPN service fails or speed test shows bad results (<0.5MBps), vpngate-clients switches to the next available public OpenVPN server.
- systemd service;
- .deb packages;
- fault-tollerance;
- ability to run in the Linux Network Namespace;

## [torctl](https://github.com/dzianisv/torctl)
A fork for BlakcArch/torctl. Adopted for Debian/Ubuntu-like OS.
- .deb packages;
- systemd service;

## [ToxVPN](https://gitlab.com/dzianisv/toxvpn)
A Mesh Peer-to-Peer VPN based on [Tox](https://tox.chat).
- Bypass NAT and Firewalls;
- Decentrailzed;
- Peer-to-peer/Mesh;

##  [Craigslist Telegram Bot](https://github.com/dzianisv/craigsbot)
Helps to track for a new CraigsList items.
- Subscribe over [Telegram](https://telegram.org);
- Notifies immediatelly when a new CraigsList item is published;
- Telegram Bot interface;


## [Realtor Fedor Telegram Bot](https://gitlab.com/distributex/realtor)
Helps to find a private property for Rent or Buying.

- Subscribe over [Telegram](https://telegram.org);
- Notifies immediatelly when a new Property is discovered;
- Telegram Bot interface;

## [Wizzair, Ryanair, Norwegian crawler](https://gitlab.com/travelingbug/crawler)
As a part of my project [Travelingbug](https://travelingbug.netlify.app) I worked on Wizzair, Norwegian and Ryanair aircraft flights scrappers. To simplify life to the other developers, I open-sourced this project.
- Microservices are written on Js/NodeJS.
- Packed into Docker image
- Wizzair required Browser-automation, so NightmareJS + xvfb were used to automate this task.

## [Google Image Search automation tool](https://gitlab.com/travelingbug/images-scraper)

For my [Travleingbug](https://travelingbug.netlify.app) project I need a royalty free pictures of the cities. Google Images API is not free, so I automated this task over Browser-automation. To choose a best image, I used [MobileNetSSD](https://gitlab.com/travelingbug/object-detection) to detect undesired objects on pictures, in order to pick a picture without these objects.

## [End-to-End Encrypted Pass manager](https://github.com/keeweb/keeweb)
I forked and extended KeyWeb web app in order to store end-to-end encrypted database in the Firebase Database.

## [Geophoto: puts labels with a photo location](https://github.com/dzianisv/geophoto)
I created this tool to create a "How I spend this year" social media video. Use it to "glue" all your photos in a video clip.

## [Embeded Linux tools](https://github.com/dzianisv/utils/blob/master/bin/chroot-arm)
If you  like to play with Armbian and Single Board Computers like as RaspberryPi, OrangePi, BananaPi (like me) you will probably will like this set of scripts I use to boostrap images and setup basic staff using chroot on your host Linux machine.
