#!/usr/bin/env bash
#如果编译安装需要安装gcc
#yum -y install make gcc gcc-c++ kernel-devel m4 ncurses-devel openssl-devel unixODBC unixODBC-devel httpd python-simplejson
#安装所需的组件
yum install unixODBC unixODBC-devel wxBase wxGTK SDL wxGTK-gl
#安装erlang环境
yum install erlang
#确认erlang环境配置
erl
#下载rabbitmq
wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.6/rabbitmq-server-3.6.6-1.el7.noarch.rpm
#安装rabbitmq
yum install rabbitmq-server-3.6.6-1.el7.noarch.rpm
#启动rabbitmq服务
systemctl start rabbitmq-server.service
#查看rabbitmq状态
systemctl status rabbitmq-server.service
#开启图形化界面
rabbitmq-plugins enable rabbitmq_management

#添加用户，后面两个参数分别是用户名和密码都是superrd
rabbitmqctl add_user superrd superrd
#添加权限
rabbitmqctl set_permissions -p / superrd ".*" ".*" ".*"
#修改用户角色
rabbitmqctl set_user_tags superrd administrator



#常用命令
#查看队列信息
rabbitmqctl list_queues
#查看运行信息
rabbitmqctl status
#查看用户列表
rabbitmqctl list_users