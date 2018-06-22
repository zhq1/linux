#!/usr/bin/env bash
#查看120.79.102.6 88端口是否开启
echo "" > /dev/tcp/120.79.102.6/88
#抓取192.168.1.178和8888端口的包
tcpdump -i any  host 192.168.1.178  and port 8888
