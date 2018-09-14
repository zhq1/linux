#!/usr/bin/env bash
#好分销系统php_win移植linux记录 因为开发年代比较久远,故版本选择还是之前选择的版本为准
#此次环境为centos 7.4 64
#下载安装包
wget http://yellowcong.qiniudn.com/php-5.6.32.tar.gz
#解压
tar -zxvf php-5.6.32.tar.gz
#安装php编译依赖，不然会报错
yum install -y libxml2 libxml2-devel
#配置php
./configure --prefix=/usr/local/php
#编译并安装
make && make install 
#建立管道连接
#centos 6.x系列
ln -s /usr/local/php/bin/php ./php
#centos 7.x系列
ln -s /usr/local/php/bin/php /usr/sbin/php
#查看php版本
php -v
#查看php扩展模块
php -m
#php7编译安装详见https://www.cnblogs.com/jkko123/p/6357670.html

#php5-fpm是一个PHPFastCGI管理器，提供了更好的PHP进程管理方式，可以有效控制内存和进程、可以平滑重载PHP配置，
#其配置文件默认在/etc/php5/fpm下，若无特殊需求，一般不用配置
#查看php-fpm的版本及安装
yum list|grep fpm
yum install -y php-fpm
#配置php-fpm
#直接启动
php-fpm &
systemctl restart php-fpm

#页面展示选择轻量的nginx
yum install -y nginx
vi /etc/nginx/nginx.conf
server {
    listen  80;
    server_name    192.168.1.61; # 自己PC的ip或者服务器的域名
    charset utf-8; # 避免中文乱码
    root /opt/WWW/fx.mymvac.com; # 存放文件的目录
    include /etc/nginx/default.d/*.conf;

    location / {
        index index.php index.html index.htm;
        charset utf-8;
#        autoindex on; # 索引
#        autoindex_exact_size on; # 显示文件大小
#        autoindex_localtime on; # 显示文件时间

    }
   location ~ \.php$ {
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;

    }
        }

#在工作目录设置测试文件
vi /opt/WWW/fx.mvmvac.com/phpinfo.php
<?php

    // 顺便可以看一下php的扩展全不全
    phpinfo();
?>
#访问地址测试
http://192.168.1.61/phpinfo.php




#php优化参数详解 参考地址http://www.4wei.cn/archives/1002061
vi /etc/php-fpm.conf

pid = run/php-fpm.pid
#pid设置，默认在安装目录中的var/run/php-fpm.pid，建议开启
 
error_log = log/php-fpm.log
#错误日志，默认在安装目录中的var/log/php-fpm.log
 
log_level = notice
#错误级别. 可用级别为: alert（必须立即处理）, error（错误情况）, warning（警告情况）, notice（一般重要信息）, debug（调试信息）. 默认: notice.
 
emergency_restart_threshold = 60
emergency_restart_interval = 60s
#表示在emergency_restart_interval所设值内出现SIGSEGV或者SIGBUS错误的php-cgi进程数如果超过 emergency_restart_threshold个，php-fpm就会优雅重启。这两个选项一般保持默认值。
 
process_control_timeout = 0
#设置子进程接受主进程复用信号的超时时间. 可用单位: s(秒), m(分), h(小时), 或者 d(天) 默认单位: s(秒). 默认值: 0.
 
daemonize = yes
#后台执行fpm,默认值为yes，如果为了调试可以改为no。在FPM中，可以使用不同的设置来运行多个进程池。 这些设置可以针对每个进程池单独设置。
 
listen = 127.0.0.1:9000
#fpm监听端口，即nginx中php处理的地址，一般默认值即可。可用格式为: 'ip:port', 'port', '/path/to/unix/socket'. 每个进程池都需要设置.
 
listen.backlog = -1
#backlog数，-1表示无限制，由操作系统决定，此行注释掉就行。backlog含义参考：http://www.3gyou.cc/?p=41
 
listen.allowed_clients = 127.0.0.1
#允许访问FastCGI进程的IP，设置any为不限制IP，如果要设置其他主机的nginx也能访问这台FPM进程，listen处要设置成本地可被访问的IP。默认值是any。每个地址是用逗号分隔. 如果没有设置或者为空，则允许任何服务器请求连接
 
listen.owner = www
listen.group = www
listen.mode = 0666
#unix socket设置选项，如果使用tcp方式访问，这里注释即可。
 
user = www
group = www
#启动进程的帐户和组
 
pm = dynamic #对于专用服务器，pm可以设置为static。
#如何控制子进程，选项有static和dynamic。如果选择static，则由pm.max_children指定固定的子进程数。如果选择dynamic，则由下开参数决定：
pm.max_children #，子进程最大数
pm.start_servers #，启动时的进程数
pm.min_spare_servers #，保证空闲进程数最小值，如果空闲进程小于此值，则创建新的子进程
pm.max_spare_servers #，保证空闲进程数最大值，如果空闲进程大于此值，此进行清理
 
pm.max_requests = 1000
#设置每个子进程重生之前服务的请求数. 对于可能存在内存泄漏的第三方模块来说是非常有用的. 如果设置为 '0' 则一直接受请求. 等同于 PHP_FCGI_MAX_REQUESTS 环境变量. 默认值: 0.
 
pm.status_path = /status
#FPM状态页面的网址. 如果没有设置, 则无法访问状态页面. 默认值: none. munin监控会使用到
 
ping.path = /ping
#FPM监控页面的ping网址. 如果没有设置, 则无法访问ping页面. 该页面用于外部检测FPM是否存活并且可以响应请求. 请注意必须以斜线开头 (/)。
 
ping.response = pong
#用于定义ping请求的返回相应. 返回为 HTTP 200 的 text/plain 格式文本. 默认值: pong.
 
request_terminate_timeout = 0
#设置单个请求的超时中止时间. 该选项可能会对php.ini设置中的'max_execution_time'因为某些特殊原因没有中止运行的脚本有用. 设置为 '0' 表示 'Off'.当经常出现502错误时可以尝试更改此选项。
 
request_slowlog_timeout = 10s
#当一个请求该设置的超时时间后，就会将对应的PHP调用堆栈信息完整写入到慢日志中. 设置为 '0' 表示 'Off'
 
slowlog = log/$pool.log.slow
#慢请求的记录日志,配合request_slowlog_timeout使用
 
rlimit_files = 1024
#设置文件打开描述符的rlimit限制. 默认值: 系统定义值默认可打开句柄是1024，可使用 ulimit -n查看，ulimit -n 2048修改。
 
rlimit_core = 0
#设置核心rlimit最大限制值. 可用值: 'unlimited' 、0或者正整数. 默认值: 系统定义值.
 
chroot =
#启动时的Chroot目录. 所定义的目录需要是绝对路径. 如果没有设置, 则chroot不被使用.
 
chdir =
#设置启动目录，启动时会自动Chdir到该目录. 所定义的目录需要是绝对路径. 默认值: 当前目录，或者/目录（chroot时）
 
catch_workers_output = yes
#重定向运行过程中的stdout和stderr到主要的错误日志文件中. 如果没有设置, stdout 和 stderr 将会根据FastCGI的规则被重定向到 /dev/null . 默认值: 空.        