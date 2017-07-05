#!/bin/bash
#监控系统负载与CPU、内存、硬盘、登录用户数，超出警戒值则发邮件告警。

#获取系统当前时间
time=`date +"%Y-%m-%d %H:%M:%S"`
#获取内网IP
inner=$(hostname -I)

#获取外网IP
outer=$(curl -s http://ipecho.net/plain)

# 1、监控系统负载的变化情况，超出时发邮件告警：
 
#抓取cpu的总核数
cpu_num=`cat /proc/cpuinfo | grep -c "model name"`
 
#抓取当前系统15分钟的平均负载值
load_15=`uptime | awk '{print $10}'`
 
#计算当前系统单个核心15分钟的平均负载值，结果小于1.0时前面个位数补0。
average_load=`echo "scale=2;a=$load_15/$cpu_num;if(length(a)==scale(a)) print 0;print a" | bc`
 
#取上面平均负载值的个位整数
#average_int=`echo $average_load | cut -f 1 -d "."`
 
#设置系统单个核心15分钟的平均负载的告警值为0.70(即使用超过70%的时候告警)。
load_warn=0.70
 
#当单个核心15分钟的平均负载值大于等于1.0（即个位整数大于0） ，直接发邮件告警；如果小于1.0则进行二次比较
#if [[ $average_int < 0 ]]; then
#echo "$inner服务器单个核心15分钟的系统平均负载为$average_load，系统正常,当前时间为$time"
#else
 
#当前系统15分钟平均负载值与告警值进行比较（当大于告警值0.70时会返回1，小于时会返回0）
load_now=`expr $average_load \> $load_warn`
 
#如果系统单个核心15分钟的平均负载值大于告警值0.70（返回值为1），则发邮件给管理员
if [[ $load_now == 0 ]]; then
echo "$inner服务器单个核心15分钟的系统平均负载为$average_load，系统正常,当前时间为$time"
fi
#fi
 
 
 
 
# 2、监控系统cpu的情况，当使用超过80%的时候发告警邮件：
 
#取当前空闲cpu百份比值（只取整数部分）
cpu_idle=`top -b -n 1 | grep Cpu | awk '{print $5}' | cut -f 1 -d "."`
 
#设置空闲cpu的告警值为20%，如果当前cpu使用超过80%（即剩余小于20%），立即发邮件告警
if [[ $cpu_idle > 20 ]]; then
echo "$inner服务器cpu剩余$cpu_idle%，系统正常,当前时间为$time"
fi
 
 
 
 
 
# 3、监控系统内存的情况，当使用超过80%的时候发告警邮件：
 
#系统分配的内存总量
mem_total=`free -m | grep Mem | awk '{print $2}'`
 
#当前剩余的内存free大小
mem_free=`free -m | grep Mem | awk '{print $4}'`
 
#当前已使用的内存used大小
mem_used=`free -m | grep Mem | awk '{print $3}'`
 
#计算当前内存free所占总量的百分比，用小数来表示，要在小数点前面补一个整数位0
mem_per=0`echo "scale=2;$mem_free/$mem_total" | bc`
 
#设置内存的告警值为20%(即使用超过80%的时候告警)。
mem_warn=0.20
 
#当前剩余内存百分比与告警值进行比较（当大于告警值(即剩余20%以上)时会返回1，小于(即剩余不足20%)时会返回0 ）
mem_now=`expr $mem_per \> $mem_warn`
 
#如果当前内存使用超过80%（即剩余小于20%，上面的返回值等于0），立即发邮件告警
if (($mem_now != 0)); then
echo "$inner服务器内存剩下 $mem_free M 未使用，系统正常，当前时间为$time"
fi
#fi
 
 
 
 
# 4、监控系统硬盘根分区使用的情况，当使用超过80%的时候发告警邮件：
 
#取当前根分区（/dev/sda3）已用的百份比值（只取整数部分）
disk_sda3=`df -h | grep /dev/sda3 | awk '{print $5}' | cut -f 1 -d "%"`
 
#设置空闲硬盘容量的告警值为80%，如果当前硬盘使用超过80%，立即发邮件告警
if (($disk_sda3 < 80)); then
echo "$inner 服务器 /根分区 使用率为$disk_sda3，系统正常，当前时间为$time"
fi
 

#6 系统异常登录
tail  /var/log/secure | grep "Failed"
if [ $? -ne 0 ]
then
echo "系统没有用户异常登录：LOGIN，系统正常，当前时间为$time"
fi

