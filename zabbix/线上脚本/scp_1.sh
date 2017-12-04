#!/bin/bash
>/root/.ssh/known_hosts
for j in 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 111 112 113 114 115 116 121 122 123 124 125 126
do
	
	ip2=10.10.66.$j
		/usr/bin/expect <<-EOF
		set timeout 30
		spawn scp -P 62017 /root/log/login.sh $ip2:/root/
		expect {
			"yes/no" { send "yes\r";exp_continue}
			"*password:" { send "填写密码\r" }
		}
		expect eof
		EOF
done
