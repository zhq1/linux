#redis_cluster_install 此集群为伪集群
#By Myki
#CentOS Linux release 7.4.1708 (Core)  redis  latest ruby  latest
#参考https://www.cnblogs.com/lianggp/articles/8136222.html

#在docker库获取redis镜像
docker pull redis
#在docker库获取ruby镜像
docker pull ruby

vi /home/redis-cluster/redis-cluster.tmpl
port ${PORT}
protected-mode no
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip 192.168.10.34
cluster-announce-port ${PORT}
cluster-announce-bus-port 1${PORT}
appendonly yes

#创建自定义network
docker network create redis-net

cd /home/redis-cluster

for port in `seq 7000 7005`; do \
  mkdir -p ./${port}/conf \
  && PORT=${port} envsubst < ./redis-cluster.tmpl > ./${port}/conf/redis.conf \
  && mkdir -p ./${port}/data; \
done

#创建6个redis容器
for port in `seq 7000 7005`; do \
  docker run -d -ti -p ${port}:${port} -p 1${port}:1${port} \
  -v /home/redis-cluster/${port}/conf/redis.conf:/usr/local/etc/redis/redis.conf \
  -v /home/redis-cluster/${port}/data:/data \
  --restart always --name redis-${port} --net redis-net \
  --sysctl net.core.somaxconn=1024 redis redis-server /usr/local/etc/redis/redis.conf; \
done


#通过启动ruby来实现集群
echo yes | docker run -i --rm --net redis-net ruby sh -c '\
  gem install redis \
  && wget http://download.redis.io/redis-stable/src/redis-trib.rb \
  && ruby redis-trib.rb create --replicas 1 \
  '"$(for port in `seq 7000 7005`; do \
    echo -n "$(docker inspect --format '{{ (index .NetworkSettings.Networks "redis-net").IPAddress }}' "redis-${port}")":${port} ' ' ; \
  done)"
  
  
  #阿里云上要添加安全组，除了7000-7005端口，还要开放17000-17005端口