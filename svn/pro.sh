#!/bin/sh
while true; do
#启动一个循环，定时检查进程是否存在
	svns=`netstat -anlp|grep 3690|grep -v grep`
	if [ ! "$svns" ]; then
		#如果不存在就重新启动
		nohup svnserve -d -r /var/svn/svnrepos &
		sleep 10
		#启动后沉睡10秒
	fi
	#每次循环沉睡5秒
	sleep 5
done
