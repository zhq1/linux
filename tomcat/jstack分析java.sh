#闲来无事查看java占用cpu问题查到好用的工具mark一下
#参考连接https://www.cnblogs.com/lishijia/p/5549980.html
top
#pid 8526
ps -mp 8526 -o THREAD,tid,time
#pid转换成16进制
printf "%x\n" 8534
#分析代码
jstack 8526 |grep 2156 -A 30

jstack 8526 |grep 'printf "%x\n" 8534' -A 30


#参看连接https://blog.csdn.net/gkqqq/article/details/76572523
#top获取占用最大cpu的进程
top
#把当前日志运行java打印到日志里面
 jstack 6633 > cpu1128.log 
 #获取pid
 top -p 6633 -H
 #查看PID=5159
 #接着要看刚才dump出来的cpu日志了，里面会有6633这个进程下面每个线程的栈信息，但是是十六进制显示的，所以先把5159转换成16进制
 printf %0x 5159
 vi cpu1128.log
