#redis_cluster_install 此集群为伪集群
#By Myki
#centos 7.4  redis  4.0.11 ruby  2.3.7
#参考https://blog.csdn.net/Hello_World_QWP/article/details/78257428?locationNum=6&fps=1

#下载源码包兵安装
wget http://download.redis.io/releases/redis-4.0.11.tar.gz
tar -zxvf redis-4.0.11.tar.gz
cd redis-4.0.11/
make && make install

#创建redis工作目录
mkdir /opt/redis-cluster/redis-01
mkdir /opt/redis-cluster/redis-02
mkdir /opt/redis-cluster/redis-03
mkdir /opt/redis-cluster/redis-04
mkdir /opt/redis-cluster/redis-05
mkdir /opt/redis-cluster/redis-06

#redis配置文件
vi /root/redis-4.0.11/redis.conf
port 7000
daemonize yes
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes

#将配置文件拷贝到工作目录
cp /root/redis-4.0.11/redis.conf /opt/redis-cluster/redis-01
cp /root/redis-4.0.11/redis.conf /opt/redis-cluster/redis-02
cp /root/redis-4.0.11/redis.conf /opt/redis-cluster/redis-03
cp /root/redis-4.0.11/redis.conf /opt/redis-cluster/redis-04
cp /root/redis-4.0.11/redis.conf /opt/redis-cluster/redis-05
cp /root/redis-4.0.11/redis.conf /opt/redis-cluster/redis-06

#拷贝rb管理集群
cp /root/redis-4.0.11/src/redis-trib.rb /opt/redis-cluster/

cp redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-sentinel redis-server /opt/redis-cluster/redis-01/
cp redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-sentinel redis-server /opt/redis-cluster/redis-02/
cp redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-sentinel redis-server /opt/redis-cluster/redis-03/
cp redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-sentinel redis-server /opt/redis-cluster/redis-04/
cp redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-sentinel redis-server /opt/redis-cluster/redis-05/
cp redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-sentinel redis-server /opt/redis-cluster/redis-06/

#启动脚本
vi /opt/redis-cluster/redis-start-all.sh
chmod 777 /opt/redis-cluster/redis-start-all.sh


sed -i 's/bind 127.0.0.1/bind 192.168.1.62/g' redis-01/redis.conf
sed -i 's/bind 127.0.0.1/bind 192.168.1.62/g' redis-02/redis.conf
sed -i 's/bind 127.0.0.1/bind 192.168.1.62/g' redis-03/redis.conf
sed -i 's/bind 127.0.0.1/bind 192.168.1.62/g' redis-04/redis.conf
sed -i 's/bind 127.0.0.1/bind 192.168.1.62/g' redis-05/redis.conf
sed -i 's/bind 127.0.0.1/bind 192.168.1.62/g' redis-06/redis.conf
sed -i 's/port 6379/port 9001/g' redis-01/redis.conf
sed -i 's/port 6379/port 9002/g' redis-02/redis.conf
sed -i 's/port 6379/port 9003/g' redis-03/redis.conf
sed -i 's/port 6379/port 9004/g' redis-04/redis.conf
sed -i 's/port 6379/port 9005/g' redis-05/redis.conf
sed -i 's/port 6379/port 9006/g' redis-06/redis.conf


#redis-trib.rb是采用Ruby实现的Redis集群管理工具，使用之前需要安装Ruby依赖环境
tar -zxvf ruby-2.3.7.tar.gz
cd ruby-2.3.7/
./configure --prefix=/opt/ruby
make && make install
ln -s /opt/ruby/bin/ruby /usr/bin/ruby
ln -s /opt/ruby/bin/gem /usr/bin/gem
ruby -v
gem install redis
#gem install redis如果卡住一直不动  就是ruby版本过低这里遇到个小坑

kill $(pgrep redis)

#创建集群
./redis-trib.rb create --replicas 1 192.168.1.62:9001 192.168.1.62:9002 192.168.1.62:9003 192.168.1.62:9004 192.168.1.62:9005 192.168.1.62:9006

#连接集群
redis-cli -c -h 192.168.1.62 -p 9001
set money 1000
 