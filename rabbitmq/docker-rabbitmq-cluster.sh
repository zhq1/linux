#rabbitmq_cluster_install 此集群为伪集群
#By Myki
#centos 7.4  docker集成  
#参考https://www.cnblogs.com/cheyunhua/p/8362200.html

#安装docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

#安装git并下载yam文件
yum install -y git
git clone https://github.com/bijukunjummen/docker-rabbitmq-cluster.git
cd docker-rabbitmq-cluster/cluster/

#docker配置文件
vi /root/docker-rabbitmq-cluster/cluster/docker-compose.yml
rabbit1:
  image: bijukunjummen/rabbitmq-server:3.7.0
  hostname: rabbit1
  ports:
    - "5672:5672"
    - "15672:15672"
  environment:
    - RABBITMQ_DEFAULT_USER=myuser
    - RABBITMQ_DEFAULT_PASS=mypass
rabbit2:
  image: bijukunjummen/rabbitmq-server:3.7.0
  hostname: rabbit2
  links:
    - rabbit1
  environment:
   - CLUSTERED=true
   - CLUSTER_WITH=rabbit1
   - RAM_NODE=true
  ports:
      - "5673:5672"
      - "15673:15672"

rabbit3:
  image: bijukunjummen/rabbitmq-server:3.7.0
  hostname: rabbit3
  links:
    - rabbit1
    - rabbit2
  environment:
   - CLUSTERED=true
   - CLUSTER_WITH=rabbit1
  ports:
        - "5674:5672"
		

docker-compose up -d