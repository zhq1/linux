#!/bin/sh
# check haproxy server status
HAPROXY=/etc/init.d/haproxy
PORT=18080
nmap localhost -p $PORT | grep "$PORT/tcp open"
#echo $?
if [ $? -ne 0 ];then
    $HAPROXY start
    sleep 3
    nmap localhost -p $PORT | grep "$PORT/tcp open"
    [ $? -ne 0 ] && /etc/init.d/keepalived stop
fi

