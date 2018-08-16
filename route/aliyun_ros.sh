#建议用路版图安装ros因为ros有路版图的发行版 兼容性和是不错的
#测试用的是Ubuntu 16.04 64位
wget http://download2.mikrotik.com/routeros/6.40.8/chr-6.40.8.img.zip
unzip chr-6.40.8.img.zip
dd if=/root/chr.img bs=1024 of=/dev/vda

ip address add address=115.28.8.11/255.255.252.0 interface=ether1

ip route add dst-address=0.0.0.0/0 gateway=10.66.183.247




10.66.180.145
255.255.252.0

115.28.8.11
255.255.252.0

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         ip route add dst-address=10.0.0.0/8 gateway=   0.0.0.0         UG    0      0        0 eth1
10.0.0.0        10.66.183.247   255.0.0.0       UG    0      0        0 eth0
10.66.180.0     0.0.0.0         255.255.252.0   U     0      0        0 eth0
100.64.0.0      10.66.183.247   255.192.0.0     UG    0      0        0 eth0
115.28.8.0      0.0.0.0         255.255.252.0   U     0      0        0 eth1
172.16.0.0      10.66.183.247   255.240.0.0     UG    0      0        0 eth0

nameserver 10.143.22.116
nameserver 10.143.22.118
options timeout:2 attempts:3 rotate single-request-reopen

