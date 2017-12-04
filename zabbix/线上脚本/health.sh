#!/bin/bash
>/root/.ssh/known_hosts
yum install -y expect
for i in  46 47 48 49 52 53 55 56 57 58 60 42 43
do
	
	ip=59.252.101.$i
		/usr/bin/expect <<-EOF
		set timeout 30
		spawn ssh -p 62017 $ip
		expect {
			"yes/no" { send "yes\r";exp_continue}
			"*password:" { send "填写密码\r" }
		}
		expect "#"
		send "df -h\r"
		send "free -m\r"
		send "top -n 2| grep 'Cpu'\r"
		expect "#"
		send "exit\r"
		expect eof
		EOF
	
done
wait

for j in 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 111 112 113 114 115 116 121 122 123 124 125 126 71 74 89 90 83 84 85 86 87 91 78 79 94
do
	
	ip2=10.10.66.$j
		/usr/bin/expect <<-EOF
		set timeout 30
		spawn ssh -p 62017 $ip2
		expect {
			"yes/no" { send "yes\r";exp_continue}
			"*password:" { send "填写密码\r" }
		}
		expect "#"
		send "df -h\r"
		send "free -m\r"
		send "top -n 2| grep 'Cpu'\r"
		expect "#"
		send "exit\r"
		expect eof
		EOF
done
wait

for j in 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 171 172 177 
do
	
	ip2=10.10.66.$j
		/usr/bin/expect <<-EOF
		set timeout 30
		spawn ssh -p 62017 $ip2
		expect {
			"yes/no" { send "yes\r";exp_continue}
			"*password:" { send "填写密码\r" }
		}
		expect "#"
		send "df -h\r"
		send "free -m\r"
		send "top -n 2| grep 'Cpu'\r"
		expect "#"
		send "exit\r"
		expect eof
		EOF
done
wait
