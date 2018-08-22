#安装nfs
yum install -y nfs-utils

vim /etc/exports
/home/nfs/ 192.168.10.0/24(rw,sync,no_root_squash)

#rw表示可读写；sync表示同步写，fsid=0表示将/data找个目录包装成根目录


#先为rpcbind和nfs做开机启动：(必须先启动rpcbind服务)
systemctl enable rpcbind.service
systemctl enable nfs-server.service

#然后分别启动rpcbind和nfs服务：
systemctl start rpcbind.service
systemctl start nfs-server.service


#确认NFS服务器启动成功：

rpcinfo -p
检查 NFS 服务器是否挂载我们想共享的目录 /home/nfs/：

exportfs -r
#使配置生效

exportfs
#可以查看到已经ok
/home/nfs 192.168.248.0/24


#在从机上安装NFS 客户端
systemctl enable rpcbind.service
systemctl start rpcbind.service

#注意：客户端不需要启动nfs服务
#检查 NFS 服务器端是否有目录共享：showmount -e nfs服务器的IP
showmount -e 192.168.248.208
Export list for 192.168.248.208:
/home/nfs 192.168.248.0/24

mkdir /opt/nfs

mount -t nfs 192.168.10.34:/home/nfs/ /opt/nfs