#!/usr/bin/env bash
#获取192.168.2.4 /datawww/logs下面的文件到home下
rsync -av root@192.168.2.4:/data/wwwlogs /home
#上传/root/myki本地文件夹到192.168.2.4的/data下
rsync -av /root/myki root@192.168.2.4:/data/


#记一次同步centos5 yum源从腾讯云同步到本地 2018年7月9日 10:00:26
#两台服务器安装同步软件
yum install -y rsync
#服务端
cat /etc/rsyncd.conf
uid = root
gid = root
max connections = 4
use chroot = no
log file = /var/log/rsyncd.log
pid file = /var/run/rsyncd.pid
lock file = /var/run/rsync.lock
transfer logging = yes
log format = %t %a %m %f %b
syslog facility = local3
timeout = 300
hosts allow = 124.205.193.74
hosts deny = *        # 哪些IP不可以访问rsync服务  0/24 代表 192.168.100 该IP段


[ftp_backup]
path = /root/mirrors.tencentyun.com/
comment = ftp backup folder
auth users = root
ignore errors
read only = yes
list = no
auth users = root
secrets file = /etc/rsyncd/rsyncd.passwd

vim /etc/rsyncd/rsyncd.passwd
root:123456

chmod 600 /etc/rsyncd/rsyncd.passwd
/usr/bin/rsync --daemon &
#客户端
vi /etc/rsyncd.passwd
123456
chmod 600 /etc/rsyncd.passwd

客户端
#接收
rsync -avzP --delete --password-file=/etc/rsyncd.pwd root@140.143.237.96::ftp_backup /data/ftp/ > /dev/null 2>&1
#发送
rsync -avzP /root/cheche  root@140.143.237.96::epel --password-file=/etc/rsyncd.passwd

/usr/bin/rsync -auvrtzopgP --progress --password-file=/etc/rsync_client.pwd rsyncuser@172.16.250.200::module_test /tmp/ 


#常见错误
错误1: rsync: read error: Connection reset by peer (104) 
rsync error: error in rsync protocol data stream (code 12) at io.c(794) [receiver=3.0.2] 
解决：很大可能是服务器端没有开启 rsync 服务。开启服务。 或者开启了防火墙指定的端口无法访问。 

错误2：@ERROR: chdir failed 
rsync error: error starting client-server protocol (code 5) at main.c(1495) [receiver=3.0.2] 
解决：服务器端同步目录没有权限，cwrsync默认用户是Svcwrsync。为同步目录添加用户Svcwrsync权限。 

错误3：@ERROR: failed to open lock file 
rsync error: error starting client-server protocol (code 5) at main.c(1495) [receiver=3.0.2] 
解决：服务器端配置文件 rsyncd.conf中添加 lock file = rsyncd.lock 即可解决。 

错误4：@ERROR: invalid uid nobody 
rsync error: error starting client-server protocol (code 5) at main.c(1506) [Receiver=3.0.2] 
解决：在rsyncd.conf文件中添加下面两行即可解决问题 
UID = 0 
GID = 0 

错误5：@ERROR: auth failed on module test2 
rsync error: error starting client-server protocol (code 5) at main.c(1296) [receiver=3.0.2] 
解决：服务端没有指定正确的secrets file，请在 [test2]配置段添加如下配置行： 
auth users = coldstar #同步使用的帐号 
secrets file = rsyncd.secrets #密码文件 

错误6：password file must not be other-accessible 
解决：客户端的pass文件要求权限为600, chmod 600 /etc/rsync.pass 即可。 

错误7：rsync: chdir /cygdrive/c/work failed
: No such file or directory (2)
解决：服务器端同步文件夹路径或名称写错了，检查path。

===============================================================

rsyncserver 服务启动时报错“rsyncserver服务启动后又停止了。一些服务自动停止，如果它们没有什么可做的，例如“性能日志和警报”服务。”

解决方法：将安装目录下的rsyncd.pid文件删除，再重新启动RsyncServer服务。一般是异常关机导致的