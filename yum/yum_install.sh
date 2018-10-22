#腾讯云wget递归下载
wget -nc -np -c -r -v --reject=html --ignore-tags=robots.txt http://mirrors.tencentyun.com/centos/5.11/os/
wget -nc -np -c -r -v --reject=html --ignore-tags=robots.txt http://mirrors.tencentyun.com/epel/5/
#nohup wget -nc -np -c -r -v --reject=html --ignore-tags=robots.txt http://yum.1nth.com/base/   /dev/null 2>&1 &


yum install nginx
#配置nginx配置文件
vim /etc/nginx/nginx.conf

#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;
server {
    listen  80;
    server_name    140.143.237.96; # 自己PC的ip或者服务器的域名
    charset utf-8; # 避免中文乱码
#    root /mirrors.tencentyun.com/epel/; # 存放文件的目录
    location ^~ /epel {
        alias /mirrors.tencentyun.com/epel/;
        charset utf-8;
        autoindex on; # 索引
        autoindex_exact_size on; # 显示文件大小
        autoindex_localtime on; # 显示文件时间
    }
    location ^~ /base {
        alias /mirrors.tencentyun.com/centos/5.11/os/;
        charset utf-8;
        autoindex on; # 索引
        autoindex_exact_size on; # 显示文件大小
        autoindex_localtime on; # 显示文件时间
    }
}



}


mkdir /data
mkdir /data/yum_data


google了一下，说是在rhel 6 中 repomd.xml 文件使用 sha256 作为hash 算法 ，在rhel 5中 默认使用的是sha 作为hash 算法。

但我是在redhat 5.8 上使用5.9的yum。 也出现了这种错误。

网上的解决方法是：使用新的sha1 来重建repo：

# createrepo -s sha1 dave-el5-x86_64
createrepo -s sha1 ./
createrepo -s sha1 -pdo /mirrors.tencentyun.com/epel/5/x86_64/ /mirrors.tencentyun.com/epel/5/x86_64/













yum install -y http php
yum install createrepo
cd /var/www/html/
mkdir CentOS
mount -o loop /var/www/html/CentOS-5.11-x86_64-bin-DVD-1of2.iso /var/www/html/CentOS


mount -o loop CentOS-5.11-x86_64-bin-DVD-1of2.iso /home/5.11/
mount -o loop CentOS-5.10-x86_64-bin-DVD-1of2.iso /home/5.10/


cat <<EOF> /etc/yum.repos.d/CentOS.repo
[base]
name=CentOS
name=CentOS-$releasever - Base - Myki
baseurl=http://115.28.187.237:88/
gpgcheck=1
gpgkey=http://115.28.187.237:88/RPM-GPG-KEY-CentOS-5
EOF

yum install -y nginx
vi /etc/nginx/conf.d/fileServer.conf
server {
    listen  80;
    server_name    101.200.208.211; # 自己PC的ip或者服务器的域名
    charset utf-8; # 避免中文乱码
    root /ysdata/upgrade_file/http; # 存放文件的目录
    location / {
        autoindex on; # 索引
        autoindex_exact_size on; # 显示文件大小
        autoindex_localtime on; # 显示文件时间
    }
}


/etc/init.d/nginx reload
/etc/init.d/nginx restart



卸载报错
[root@localhost ~]# umount /var/www/html/CentOS
umount: /var/www/html/CentOS: device is busy.
        (In some cases useful info about processes that use
         the device is found by lsof(8) or fuser(1))
service httpd stop
fuser -m /var/www/html/CentOS
ps aux |grep 1680
kill -9 1680
fuser -m /var/www/html/CentOS
umount /var/www/html/CentOS
mount -o loop /var/www/html/CentOS-5.11-x86_64-bin-DVD-1of2.iso /var/www/html/centos/5.11/os/x86_64/
