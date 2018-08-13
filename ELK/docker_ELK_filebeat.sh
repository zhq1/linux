#下载sebp/elk
#ELK安装
#By Myki
#centos 7.4  ELK_least    rabbitmq 3.6.10  
#参考https://blog.csdn.net/qq_39284787/article/details/78809538
docker pull sebp/elk
#运行ELK镜像需要vm.max_map_count至少需要262144内存
vi /etc/sysctl.conf
vm.max_map_count=262144

sysctl -p
#或者
sysctl -w vm.max_map_count=262144
#启动ELK
docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name elk sebp/elk
#下载&安装Filebeat
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.1-x86_64.rpm 
cd /etc/filebeat
vi filebeat.yml


/etc/init.d/filebeat start

进入ELK容器
修改 
cd /etc/logstash/conf.d/
vi 02-beats-input.conf
input {
	beats {
		port => 5044
#		ssl => true 
#		ssl_certificate => "/pki/tls/certs/logstash.crt"
#		ssl_key => "/pki/tls/private/logstash.key"
	}
}