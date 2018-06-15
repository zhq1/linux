#DELL R730 服务器IPMI接口
yum install -y ipmitool
ipmitool lan print
ipmitool lan set 1 ipaddr 192.168.2.121
ipmitool lan set 1 netmask 255.255.252.0
ipmitool lan set 1 defgw ipaddr 192.168.1.1
ipmitool mc reset cold
#默认密码
#root/calvin
