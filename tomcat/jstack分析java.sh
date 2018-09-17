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
