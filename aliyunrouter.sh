linux服务器配置
#eth0路由
cat /etc/sysconfig/network-scripts/route-eth0
10.0.0.0/8 via 10.163.191.247 dev eth0
100.64.0.0/10 via 10.163.191.247 dev eth0
172.16.0.0/12 via 10.163.191.247 dev eth0
#eth1路由
cat /etc/sysconfig/network-scripts/route-eth1
0.0.0.0/0 via 115.28.91.247 dev eth1
#DNS配置
cat /etc/resolv.conf
options timeout:1 attempts:1 rotate
nameserver 10.202.72.116
nameserver 10.202.72.118
#网关配置
cat /etc/sysconfig/network
NETWORKING=yes
HOSTNAME=iZm5eauoq7l8043dey5k67Z
NETWORKING_IPV6=no
PEERNTP=no
GATEWAY=115.28.91.247




debian服务器配置

auto lo
iface lo inet loopback
auto eth0
iface eth0 inet static
address 10.165.52.142
netmask 255.255.248.0
up route add -net 172.16.0.0 netmask 255.240.0.0 gw 10.165.55.247 dev eth0
up route add -net 100.64.0.0 netmask 255.192.0.0 gw 10.165.55.247 dev eth0
up route add -net 10.0.0.0 netmask 255.0.0.0 gw 10.165.55.247 dev eth0
auto eth1
iface eth1 inet static
address 121.42.39.53
netmask 255.255.252.0
up route add -net 0.0.0.0 netmask 0.0.0.0 gw 121.42.39.247 dev eth1