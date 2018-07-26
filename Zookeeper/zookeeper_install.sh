#zookeeper伪集群安装（依赖java须配置java环境）
wget http://apache.fayea.com/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz
tar -zxvf zookeeper-3.4.13.tar.gz -C /data/server1
tar -zxvf zookeeper-3.4.13.tar.gz -C /data/server2
tar -zxvf zookeeper-3.4.13.tar.gz -C /data/server3

vi /data/server1/zookeeper-3.4.13/conf/zoo.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/server1/zookeeper-3.4.13/data
dataLogDir=/data/server1/zookeeper-3.4.13/data/logs
clientPort=2181
maxClientCnxns=300
autopurge.snapRetainCount=30
autopurge.purgeInterval=24
server.1=192.168.2.252:2888:3888
server.2=192.168.2.252:2889:3889
server.3=192.168.2.252:2890:3890

vi /data/server2/zookeeper-3.4.13/conf/zoo.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/server2/zookeeper-3.4.13/data
dataLogDir=/data/server2/zookeeper-3.4.13/data/logs
clientPort=2182
maxClientCnxns=300
autopurge.snapRetainCount=30
autopurge.purgeInterval=24
server.1=192.168.2.252:2888:3888
server.2=192.168.2.252:2889:3889
server.3=192.168.2.252:2890:3890

vi /data/server3/zookeeper-3.4.13/conf/zoo.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/server3/zookeeper-3.4.13/data
dataLogDir=/data/server3/zookeeper-3.4.13/data/logs
clientPort=2183
maxClientCnxns=300
autopurge.snapRetainCount=30
autopurge.purgeInterval=24
server.1=192.168.2.252:2888:3888
server.2=192.168.2.252:2889:3889
server.3=192.168.2.252:2890:3890

vi /data/server1/zookeeper-3.4.13/data/myid
1
vi /data/server2/zookeeper-3.4.13/data/myid
2
vi /data/server3/zookeeper-3.4.13/data/myid
3

bash /data/server1/zookeeper-3.4.13/bin/zkServer.sh start
bash /data/server2/zookeeper-3.4.13/bin/zkServer.sh start
bash /data/server3/zookeeper-3.4.13/bin/zkServer.sh start
#查询命令
bash zkServer.sh status
#查询启动日志
cat /data/server1/zookeeper-3.4.13/bin/zookeeper.out