#!/bin/sh
#chkconfig: 2345 80 90
#description:开机自动启动的脚本程序

#openvpn启动
nohup openvpn  --config /etc/openvpn/client/client.ovpn >/dev/null 2>&1 &
