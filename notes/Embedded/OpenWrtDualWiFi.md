

### Confiugration

`/etc/sysctl.d/default-ttl.conf`
```
net.ipv4.ip_default_ttl = 65
```

`/etc/rc.local`
```
#!/bin/sh
( while : ; do /usr/bin/isolate-vpn; sleep 10; done; ) &
```



  ```

`/etc/iproute2/rt_tables`
```
100 	vpn
128	prelocal
255	local
254	main
253	default
0	unspec
```


`/usr/bin/isolate-vpn`

```
#!/bin/sh


if ! ip rule show | grep "lookup vpn"; then
    ip rule add from 192.168.43.0/24 lookup vpn
fi

if ! route show default table vpn | grep "default via"; then
    ip route add default via 10.0.42.1 table vpn
fi

nft add rule inet fw4 mangle_forward oifname eth1 ip ttl set 65
```