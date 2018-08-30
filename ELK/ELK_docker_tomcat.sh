#filebeat-6.3.0-linux-x86_64.tar.gz, docker 18.03.1-ce, redis_version:4.0.10, docker-compose 1.18.0
#参考网址 https://www.e-learn.cn/content/linux/908878
#日志文件名称及内容
/iba/ibaboss/java/bossmobile-tomcat-8.0.26/logs/catalina.out
#截取的内容：
22-Jun-2018 17:45:22.397 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version:        Apache Tomcat/8.0.26
22-Jun-2018 17:45:22.399 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server built:          Aug 18 2015 11:38:37 UTC
22-Jun-2018 17:45:22.399 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server number:         8.0.26.0

/iba/ibaboss/java/bossmobile-tomcat-8.0.26/logs/ibalife.log
# 截取的内容：
[ERROR] [2018-06-30 17:41:56][com.iba.boss.pubsub.listener.core.ListenerTemplate]ErpCustomerRegEventListener onListen Done
[ERROR] [2018-06-30 17:41:56][com.iba.boss.pubsub.listener.user.BmcLevelDescEventListener]bmcLevelDescEventListener -> Waiting for set levelDesc
[ERROR] [2018-06-30 17:41:56][com.iba.boss.pubsub.listener.core.ListenerTemplate]BmcLevelDescEventListener onListen Done

#安装docker 以及docker-compose
curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
cp -dprf /usr/local/bin/docker-compose /usr/bin/
docker-compose --version



#安装 redis (这里使用 docker)
docker pull redis
mkdir /home/ibaboss/compose/config -p
cd  /home/ibaboss/compose/config

# redis 的配置，密码为 ibalife
vi redis.conf 

#daemonize yes
pidfile /data/redis.pid
port 6379
tcp-backlog 30000
timeout 0
tcp-keepalive 10
loglevel notice
logfile /data/redis.log
databases 16
save 900 1
save 300 10
save 60 10000
stop-writes-on-bgsave-error yes
rdbcompression yes
rdbchecksum yes
dbfilename dump.rdb
dir /data
slave-serve-stale-data yes
slave-read-only yes
repl-diskless-sync no
repl-diskless-sync-delay 5
repl-disable-tcp-nodelay no
slave-priority 100
requirepass ibalife
maxclients 30000
appendonly no
appendfilename "appendonly.aof"
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
aof-load-truncated yes
lua-time-limit 5000
slowlog-log-slower-than 10000
slowlog-max-len 128
latency-monitor-threshold 0
notify-keyspace-events KEA
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-entries 512
list-max-ziplist-value 64
set-max-intset-entries 1000
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
hll-sparse-max-bytes 3000
activerehashing yes
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit slave 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
aof-rewrite-incremental-fsync yes

# 编写 docker-compose redis yml 文件
cd /home/ibaboss/compose

vi docker-compose-redis.yml 
version: '3'
services:
  elk_redis:
    image: redis:latest
    container_name: elk_redis
    ports:
      - "192.168.0.223:6379:6379"     # 为提升安全，redis只对内网开放
    volumes:
      - ./config/redis.conf:/usr/local/etc/redis/redis.conf
    networks:
      - logs_elk  # 使用指定的网络 logs_elk
    entrypoint:
      - redis-server
      - /usr/local/etc/redis/redis.conf

networks:
  logs_elk:
    external:    # 指定使用网络
      name: logs_elk

# 创建 elk 专用的网络
docker network create  --attachable logs_elk

# 启动 redis
docker-compose -f docker-compose-redis.yml up -d 

# 查看状态
docker ps -a

# 可通过上一步获得 CONTAINER ID，查看启动日志
docker logs -f 4841efd2e1ef




#安装 filebeat
mkdir /home/tools -p

cd /home/tools

# 安装包上传到 /home/tools
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.3.0-linux-x86_64.tar.gz
tar zxvf filebeat-6.3.0-linux-x86_64.tar.gz -C /usr/local
cd /usr/local
ln -s /usr/local/filebeat-6.3.0-linux-x86_64 /usr/local/filebeat
#配置 filebeat 配置文件
cd /usr/local/filebeat

cat filebeat4bossmobile.yml
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /iba/ibaboss/java/bossmobile-tomcat-8.0.26/logs/catalina.out
  multiline.pattern: '^[0-9]{2}-[[:alpha:]]{3}-[0-9]{4}| ^Listening\ [[:alnum:]]*'
  multiline.negate: true # multiline 规则参考文章底下链接
  multiline.match: after
  fields:      # 在采集的信息中添加一个自定义字段 service，里面的值为 bossmobile_catalina，区分两类日志
    service: bossmobile_catalina

- type: log
  enabled: true
  paths:
    - /iba/ibaboss/java/bossmobile-tomcat-8.0.26/logs/ibalife.*
  multiline.pattern: '^\['
  multiline.negate: true
  multiline.match: after
  fields:      # 在采集的信息中添加一个自定义字段 service，里面的值为 bossmobile_ibalife，区分两类日志
    service: bossmobile_ibalife

output.redis:
  hosts: ["192.168.0.223"]               # 这里是 redis 的内网地址
  password: "ibalife"
  key: "bossmobile"                      # 存入到 redis 中的 bossmobile key 中
  db: 0
  timeout: 5

  
  
  
#启动 filebeat
# 创建 filebeat 保存日志的文件夹
mkdir /iba/ibaboss/filebeat_logs

nohup ./filebeat -e -c filebeat4bossmobile.yml >/iba/ibaboss/filebeat_logs/filebeat4bossmobile.log 2>&1 & 

# 如果想重新读取日志，可以停止 filebeat 后删除，再重新启动即可
ps -ef|grep filebeat

kill -9 PID

rm /usr/local/filebeat/data/registry


#安装配置 ELK

cd /home/ibaboss/compose

cat docker-compose-elk.yml 
version: '3'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:6.2.4
    container_name: logs_elasticsearch           # 给容器命名
    restart: always
    environment:
      - discovery.type=single-node
      - cluster.name=docker-cluster
      - network.host=0.0.0.0
      - discovery.zen.minimum_master_nodes=1
      - ES_JAVA_OPTS=-Xms512m -Xmx512m
    networks:
      logs_elk:     # 指定使用的网络
        aliases:
          - elasticsearch     # 该容器的别名，在 logs_elk 网络中的其他容器可以通过别名 elasticsearch 来访问到该容器

  kibana:
    image: docker.elastic.co/kibana/kibana:6.2.4
    container_name: logs_kibana
    ports:
      - "5601:5601"
    restart: always
    networks:
      logs_elk:
        aliases:
          - kibana
    environment:
      - ELASTICSEARCH_URL=http://elasticsearch:9200
      - SERVER_NAME=kibana
    depends_on:
      - elasticsearch

  logstash:
    image: docker.elastic.co/logstash/logstash:6.2.4
    container_name: logs_logstash
    restart: always
    environment:
      - LS_JAVA_OPTS=-Xmx256m -Xms256m
    volumes:
      - ./config/logstash.conf:/etc/logstash.conf
    networks:
      logs_elk:
        aliases:
          - logstash
    depends_on:
      - elasticsearch
    entrypoint:
      - logstash
      - -f
      - /etc/logstash.conf

networks:
  logs_elk:
    external:
      name: logs_elk
	  
	  
	  
	  
	  
	  
	  
cd /home/ibaboss/compose/config

cat logstash.conf

input {
        redis {
                port => "6379"                                    
                host => "elk_redis"             # redis 主机是 logs_elk 网络中的 elk_redis 主机
                data_type => "list"
                key  =>  "bossmobile"           # 从 redis 中 bossmobile key 中获取数据
                password => "ibalife"
        }

}

filter {        
     mutate { # 定义去除的字段
     remove_field => ["_id","@version","_index","_score","_type","beat.hostname","beat.name","beat.version","fields.service","input.type","offset","prospector.type","source"]
    }

  if [fields][service] == "bossmobile_catalina" {
    grok {   # 匹配 message 字段中的 时间，放入自定义的 customer_time 字段中
        match => [ "message" , "(?<customer_time>%{MONTHDAY}-%{MONTH}-%{YEAR} %{HOUR}:%{MINUTE}:%{SECOND})" ]
    }
  }
    
  if [fields][service] == "bossmobile_ibalife" {
    grok {
        match => [ "message" , "(?<customer_time>%{YEAR}-%{MONTHNUM}-%{MONTHDAY} %{HOUR}:%{MINUTE}:%{SECOND})" ]
    }
  }

    date {
       match => [ "customer_time", "dd-MMM-yyyy HH:mm:ss.SSS","yyyy-MM-dd HH:mm:ss" ]     # 格式化 customer_time 中的时间类型从string 变成 date，例如 22-Jun-2018 17:45:22.397，对应为 dd-MMM-yyyy HH:mm:ss.SSS
        locale => "en"
        target => [ "@timestamp" ]  # 替换 @timestamp 字段的值，@timestamp 的值用于 kibana 排序
        timezone => "Asia/Shanghai"
    }
 
}

output {  # 根据 redis 中的 service 的字段，分别创建不同的 elasticsearch index
  if [fields][service] == "bossmobile_catalina" {         
        elasticsearch {
                hosts => ["elasticsearch:9200"]
                index   => "bossmobile_catalina-%{+YYYY.MM.dd}"
        }
  }
  
  if [fields][service] == "bossmobile_ibalife" {
        elasticsearch {
                hosts => ["elasticsearch:9200"]
                index   => "bossmobile_ibalife-%{+YYYY.MM.dd}"
        }
  }

}

# 启动容器
cd /home/ibaboss/compose
docker-compose -f docker-compose-elk.yml  up -d

docker ps -a	  