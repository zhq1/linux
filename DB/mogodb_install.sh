#单节点
#By Myki
#centos 7.4 mogo 3.2.2 
#参考https://blog.csdn.net/leshami/article/details/53171375
#添加yum源
vi /etc/yum.repos.d/mongodb-org-3.2.repo 
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc

yum安装mogodb
yum -y install mongodb-org

#查看是否启动

#进入mogodb
mongo
>db.version()
