#下载需要的安装包
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.0.tar.gz
wget https://artifacts.elastic.co/downloads/kibana/kibana-6.3.0-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/logstash/logstash-6.3.0.tar.gz
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.3.0-linux-x86_64.tar.gz

tar -zxvf jdk-8u181-linux-x64.tar.gz -C /usr/local/
vi /etc/profile
#jdk
export JAVA_HOME=/usr/local/jdk1.8.0_181
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib/dt.JAVA_HOME/lib/tools.jar:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:${PATH}
source  /etc/profile

vi /etc/sysctl.conf
vm.max_map_count=655360

vi /etc/security/limits.conf
# End of file
* soft nofile 65536
* hard nofile 131072
* soft nproc 65536
* hard nproc 131072
sysctl -p


vi /etc/security/limits.d/20-nproc.conf
elk        soft    nproc     65536



tar -zxvf elasticsearch-6.3.0.tar.gz
tar -zxvf kibana-6.3.0-linux-x86_64.tar.gz
tar -zxvf filebeat-6.3.0-linux-x86_64.tar.gz
tar -zxvf logstash-6.3.0.tar.gz
mv * /home



#es
vi /home/elasticsearch-6.3.0/config/elasticsearch.yml
network.host: 192.168.10.34           ##服务器ip 本机
http.port: 9200                 ##服务端口

/home/elasticsearch-6.3.0/bin/elasticsearch   #命令窗运行

/home/elasticsearch-6.3.0/bin/elasticsearch  -d  #后台线程运行


#kibana
vi /home/kibana-6.3.0-linux-x86_64/config/kibana.yml
server.port: 5601       ##服务端口 
server.host: "192.168.10.34"  ##服务器ip  本机 
elasticsearch.url: "http://192.168.10.34:9200" ##elasticsearch服务地址 与elasticsearch对应



/home/kibana-6.3.0-linux-x86_64/bin/kibana       #命令窗启动
nohup ./kibana-6.3.0-linux-x86_64/bin/kibana &   #后台线程启动

#安装logstash
vi /home/logstash-6.3.0/config/logback-es.conf

input {
    tcp {
        port => 9601
        codec => json_lines
    }
}
output {
        elasticsearch {
                hosts => "192.168.10.34:9200"
        }
        stdout { codec => rubydebug}
}

#说明如下
input {                                ##input 输入源配置
     tcp {                              ##使用tcp输入源      官网有详细文档
	 port => 9601                   ##服务器监听端口9061 接受日志  默认ip localhost
	 codec => json_lines            ##使用json解析日志    需要安装json解析插件
     }
}
filter ｛                              ##数据处理
 ｝
 output {                               ##output 数据输出配置
		elasticsearch {                ##使用elasticsearch接收
			hosts => "localhost:9200"  ##集群地址  多个用，隔开
		}
		stdout { codec => rubydebug}   ##输出到命令窗口
}




#安装logstash json插件
/home/logstash-6.3.0/bin/logstash-plugin install logstash-codec-json_lines


/home/logstash-6.3.0/bin/logstash -f /home/logstash-6.3.0/config/logback-es.conf         ##命令窗形式


nohup /home/logstash-6.3.0/bin/logstash -f /home/logstash-6.3.0/config/logback-es.conf &  ##后台线程形式

kibana  创建索引
