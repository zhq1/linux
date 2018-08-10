#rabbitmq_cluster_install 此集群为伪集群
#By Myki
#centos 7.4  erlang 19.04    rabbitmq 3.6.10  

#下载erlang和rabbitmq（mq为erlang语言开发故要安装erlang环境） 
wget http://www.rabbitmq.com/releases/erlang/erlang-19.0.4-1.el7.centos.x86_64.rpm
wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.10/rabbitmq-server-3.6.10-1.el7.noarch.rpm

#安装erlang和rabbitmq
yum install erlang-19.0.4-1.el7.centos.x86_64.rpm
yum install rabbitmq-server-3.6.10-1.el7.noarch.rpm

#测试erlang环境变量是否配置
erl

#写入rabbitmq配置文件 添加外部访问的权限设置
#这里的意思是开放使用，rabbitmq默认创建的用户guest，密码也是guest，这个用户默认只能是本机访问，localhost或者127.0.0.1，从外部访问需要添加上面的配置
vi /etc/rabbitmq/rabbitmq.config
[{rabbit, [{loopback_users, []}]}].

#开启管理UI
rabbitmq-plugins enable rabbitmq_management
systemctl restart rabbitmq-server.service

vi /etc/hosts
192.168.1.62    demo-2

#添加用户并修改用户组
rabbitmqctl add_user superrd superrd
rabbitmqctl set_permissions -p / superrd ".*" ".*" ".*"
rabbitmqctl set_user_tags superrd administrator

systemctl restart rabbitmq-server.service
systemctl stop rabbitmq-server.service

#伪集群
#启动第一个节点
RABBITMQ_NODE_PORT=5672 RABBITMQ_NODENAME=rabbit@demo-2 rabbitmq-server &


#启动第二个节点
RABBITMQ_NODE_PORT=5673 RABBITMQ_NODENAME=rabbit1@demo-2 rabbitmq-server -detached
RABBITMQ_NODE_PORT=5673 RABBITMQ_SERVER_START_ARGS="-rabbitmq_management listener [{port,15673}] -rabbitmq_stomp tcp_listeners [61614] -rabbitmq_mqtt tcp_listeners [1884]" RABBITMQ_NODENAME=rabbit1 rabbitmq-server -detached
#查看rabbit1的状态
rabbitmqctl status -n rabbit1

#启动第二个节点
RABBITMQ_NODE_PORT=5674 RABBITMQ_NODENAME=rabbit2@demo-2 rabbitmq-server -detached
RABBITMQ_NODE_PORT=5674 RABBITMQ_SERVER_START_ARGS="-rabbitmq_management listener [{port,15674}] -rabbitmq_stomp tcp_listeners [61615] -rabbitmq_mqtt tcp_listeners [1885]" RABBITMQ_NODENAME=rabbit2 rabbitmq-server -detached
#查看rabbit2的状态
rabbitmqctl status -n rabbit2


#集群操作
#停止第二个节点的应用程序
rabbitmqctl -n rabbit1@demo-2 stop_app
#重新设置第二个节点的元数据和状态为清空状态
rabbitmqctl -n rabbit1@demo-2 reset
#加入第一节点
rabbitmqctl -n rabbit1@demo-2 join_cluster rabbit@demo-2
#重新启动第二节点
rabbitmqctl -n rabbit1@demo-2 start_app


#添加第三节点的完整命令
rabbitmqctl -n rabbit2@demo-2 stop_app
rabbitmqctl -n rabbit2@demo-2 reset
rabbitmqctl -n rabbit2@demo-2 join_cluster rabbit@demo-2
rabbitmqctl -n rabbit2@demo-2 start_app

#查看集群状态
rabbitmqctl cluster_status -n rabbit@demo-2