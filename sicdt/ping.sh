#!/bin/bash
echo `date "+%Y-%m-%d %H:%M:%S"` ping  >> /var/log/ping.log
ping -c 4 baidu.com >/dev/null 2>&1
echo `date "+%Y-%m-%d %H:%M:%S"` "time sync done"  >> /var/log/ntp.log
ntpdate time.sicdt.com
#每天同步一次时间
#0 0 * * * /bin/bash /opt/ping.sh
