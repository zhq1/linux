#!/bin/bash
/usr/bin/expect <<-EOF
set timeout 30
set user sihui
set pass x6a5fan@1
	spawn bash /opt/openvpn-svn.sh
	expect {
		"*Username:" { send "$user\r";exp_continue}
		"*Password:" { send "$pass\r" }
		}	
	expect eof
EOF
#添加路由
route add -net 10.10.66.0 netmask 255.255.255.0 gw 10.10.6.1
