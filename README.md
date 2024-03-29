# About Me
Hello, I am a Software Engineer with a passion for Networking and Decentralized Distributed Systems. You will find my posts and projects here on Github.

# Blogposts
- [Development](notes/Development/README.md)
- [Blockchain](notes/blockchain/README.md)
- [Trading Bots](notes/TradingBot/README.md)
- [Networking](notes/Networking/)
- [Embedded](notes/Embedded/README.md)
- [AI](notes/AI/README.md)

# My Open Source Software Projects

## [DeFiEquilibrium](https://github.com/dzianisv/DeFiEquilibrium)
EVM automated Liqudity Pools assets manager. Smart Contract developed on Solidity, webapp is built using material style controls.

## [Openhaystack Web](https://github.com/dzianisv/openhaystack-web)

I created this project because [Openhaystack](https://github.com/seemoo-lab/openhaystack) app stopped to work on a new MacOS 14, but I needed a way to see locations of my openhaystack tracker. I built BLE beacon trackers using Nordic nrf5281 microcontrollers and ultilized openhaystack-discovered way to get a location of the tracker using [Apple Find My](https://www.apple.com/icloud/find-my/). Check out [openhaystack-toolkit](https://github.com/dzianisv/openhaystack-toolkit) for the tools that helps to flash a firmware to the tracker and generate crypto keypairs.

## [Voice Assistant](https://github.com/dzianisv/VoiceAssistant)

 is an open-source project aimed at providing a comprehensive and user-friendly AI personal assistant experience. By leveraging cutting-edge Natural Language Processing (NLP) techniques, machine learning algorithms, and various APIs, it streamlines daily tasks, manages schedules, answers queries, and provides personalized recommendations. With its user-friendly interface and rich feature set, it is designed to cater to a wide spectrum of users - from individuals to businesses, and can be integrated seamlessly into various platforms.

## [lxdbox](https://github.com/dzianisv/lxdbox)

LXDbox is an LXD containers management tool. It provides a more efficient alternative to Virtual Machines (kvm/virtualbox), enabling you to run desktop applications inside LXD containers. This is especially useful when you need multiple separate work/dev environments on a single host machine. Key features include creating a container with a Guest OS, sharing a folder with a host OS, and proxying Desktop environment, Video/Camera devices, PulseAudio, and USB devices from the host OS. It also enables KVM, useful for running an Android Emulator or other VMs inside the container.

## [Photos for Documents](https://github.com/dzianisv/Photo4Documents)
Needed a new passport photo so I created an ML app this weekend that removes backgrounds, aligns faces, and crops to passport size. It utilizes face_recognition dlib-powered library for facial detection and carvekit with tracer_7b pretrained model for background removal. Now I have unlimited great passport photos without going to a photo center! Machine learning is amazing for automating repetitive tasks. Especially I liked face_recognition lib, because it allows align faces from bad photos. I tested it on my photos and on photos from Kaggle dataset. Check out my GitHub for the code and demos!

## [ERC4626 AssetManager](https://github.com/dzianisv/DeFiStrategyManager)
This is Solidity smart-contract that could be deployed to any EVM-enabled chains (Ethereum, Optimism, Avalanche-C, BNB, Arbitrum, Polygon) for ERC4626 LiquidityPool Vault automated portfolio management.
`reinvest()` allows to choose best top-perfoming Vaults and reinvest to it.


## [vpngate-client](https://github.com/dzianisv/vpngate-client)

This free, open-source OpenVPN service discovers public VPN servers on [vpngate.net](https://vpngate.net), performs health checks, and then connects to them. Health checks are performed during service work hours. If the OpenVPN service fails or a speed test shows poor results (<0.5MBps), vpngate-client switches to the next available public OpenVPN server. Features include a systemd service, .deb packages, fault tolerance, and the ability to run in the Linux Network Namespace.

## [torctl](https://github.com/dzianisv/torctl)

This is a fork of BlakcArch/torctl, adopted for Debian/Ubuntu-like OS. It offers .deb packages and a systemd service.

## [ToxVPN](https://gitlab.com/dzianisv/toxvpn)

ToxVPN is a Mesh Peer-to-Peer VPN based on [Tox](https://tox.chat). It features NAT and Firewall bypass, decentralized networking, and peer-to-peer/mesh connectivity.

## [Craigslist Telegram Bot](https://github.com/dzianisv/craigsbot)

This tool helps monitor new Craigslist items. Users can subscribe via [Telegram](https://telegram.org) and receive immediate notifications when new Craigslist items are published. It offers a Telegram Bot interface for convenience.

## [Realtor Fedor Telegram Bot](https://gitlab.com/distributex/realtor)

A handy tool for those looking to rent or buy private property. Users can subscribe via [Telegram](https://telegram.org) and get immediate notifications when new properties are discovered. The Telegram Bot interface makes it easy to use.

## [Wizzair, Ryanair, Norwegian crawler](https://gitlab.com/travelingbug/crawler)

As part of my project, [Travelingbug](https://travelingbug.netlify.app), I developed scrappers for Wizzair, Norwegian, and Ryanair flight data. To assist other developers, I have open-sourced this project. The microservices are written in Js/NodeJS and are packed into a Docker image. For Wizzair, I utilized NightmareJS + xvfb for browser-automation tasks.

## [Google Image Search automation tool](https://gitlab.com/travelingbug/images-scraper)

To source royalty-free city images for my [Travelingbug](https://travelingbug.netlify.app) project, I created this tool to automate Google Image searches. To select the best image, I used [MobileNetSSD](https://gitlab.com/travelingbug/object-detection) to detect undesired objects in images, thus enabling the tool to choose images without these objects.

## [End-to-End Encrypted Pass manager](https://github.com/keeweb/keeweb)

I extended the KeyWeb web app to store an end-to-end encrypted database in Firebase Database.

## [Geophoto: Labeler for Photo Locations](https://github.com/dzianisv/geophoto)

I developed this tool to create a "How I spent this year" social media video. It "glues" all your photos into a video clip.

## [Embedded Linux tools](https://github.com/dzianisv/utils/blob/master/bin/chroot-arm)

For those interested in Armbian and Single Board Computers like RaspberryPi, OrangePi, BananaPi, I have created a set of scripts to bootstrap images and set up basic staff using chroot on your host Linux machine.

## [Proxy Tester](https://github.com/dzianisv/proxies-tester)

This Node.js tool tests the throughput of a large list of public proxies asynchronously.
