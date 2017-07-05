#!/bin/bash

#系统重启生成的日志文件
reboot_file="/var/log/boot.log"
#系统重启时间
reboot_info=`last reboot | head -n 1`

if [ -f "$reboot_file" ]
then
#echo "当前系统正常运行:OK"
#else
echo -e "当前系统重启过:REBOOT\n系统重启时间是 $reboot_info"
#获取系统新的日志内容
reboot_log="/var/log/messages.bak"
if [ ! -f "$reboot_log" ]
then
cp /var/log/messages /var/log/messages.bak
awk '{print $0}' /var/log/messages.bak /var/log/messages |sort|uniq -u
fi
fi
rm -f /var/log/boot.log
#备份系统日志
rm -f /var/log/messages.bak
cp /var/log/messages /var/log/messages.bak
