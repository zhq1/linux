#!/bin/bash
#把屏幕上的内容清空
clear
#定义一个高亮输出的变量
output=$(tput sgr0)
 
#获取主机名￥hostname或者uname -n
hostname=$(hostname)

#获取内网IP
inner=$(hostname -I)
echo -e "内网IP:"$output $inner
 
#获取外网IP
outer=$(curl -s http://ipecho.net/plain)
echo -e "外网IP:"$output $outer
 
#获取系统当前CPU使用率
load_cpu=$(top -n 1 -b | grep "%Cpu(s)" | awk '{print $2}')
echo -e "设备总CPU使用率:"$output $load_cpu""

#获取系统硬盘情况
disk_total=$(df -h | grep -vE 'Filesystem|tmpfs' | egrep -v '/boot'|awk '{print $2}')
echo -e "设备总硬盘大小:"$output $disk_total""

disk_free=$(df -h | grep -vE 'Filesystem|tmpfs' | egrep -v '/boot'|awk '{print $4}')
echo -e "设备总硬盘剩余大小:"$output $disk_free""

disk_percent=$(df -h | grep -vE 'Filesystem|tmpfs' | egrep -v '/boot'|awk '{print $5}')
echo -e "设备总硬盘使用率:"$output $disk_percent""

#获取系统的总内存
system_total_men=$(awk '/MemTotal/ {print $2/1024}' /proc/meminfo)
echo -e "设备总内存大小:"$output $system_total_men"M"

#获取系统已经使用的内存，通过awk命令文本进行提取，然后计算出结果转换成MB
system_use_men=$(awk '/MemTotal/{total=$2}/MemFree/{free=$2}END{print (total-free)/1024}' /proc/meminfo)
echo -e "设备总内存使用大小:"$output $system_use_men"M"

#获取系统空闲的内存
system_free_men=$(awk '/MemFree/ {print $2/1024}' /proc/meminfo)
echo -e "设备总内存剩余大小:"$output $system_free_men"M"

#获取系统内存使用率
system_percent_men=`awk 'BEGIN{printf"%.2f%\n",('$system_free_men'/'$system_total_men')*100}'`
echo -e "设备总内存使用率:$output $system_percent_men"

