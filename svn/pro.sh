#!/usr/bin/env bash
while true; do
#启动一个循环，定时检查进程是否存在
        svns=`netstat -anlp|grep 3690|grep -v grep`
        getip=`netstat -anlp|grep 56667|grep -v grep`
        if [ ! "$svns" ]; then
                #如果不存在就重新启动
                nohup svnserve -d -r /var/svn/ &
        elif [ ! "$getip" ]; then
                #如果不存在就重新启动
                nohup go run GetIp.go &
                sleep 10
                #启动后沉睡10秒
        fi
        #每次循环沉睡5秒
        sleep 5
done
#nohup /opt/pro.sh >/dev/null 2>&1 &
