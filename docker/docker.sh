#查找docker ip
docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
#提交新的镜像
docker commit c3f279d17e0a  tomcat-8
#启动系统所有镜像
docker start $(docker ps -a -q)
#docker安装ELK
git clone https://github.com/deviantony/docker-elk.git
cd docker-elk/
docker-compose up -d

#docker解决中文乱码问题
yum install kde-l10n-Chinese glibc-common -y
echo " export LANG=zh_CN.UTF-8" >> /root/.bashrc
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8


#启动数据库
docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -v /home/mysql/data:/var/lib/mysql -d mysql
docker run -p 3306:3306 --name mymysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.6

#抓包分析
yum install -y tcpdump
tcpdump -i any port 8888
tcpdump -i any  host 192.168.1.178  and port 8888



#docker查看cpu和内存状态
#摘自  https://blog.csdn.net/pdw2009/article/details/78137759
#源码地址 https://github.com/docker/libcontainer/blob/v1.2.0/cgroups/fs/memory.go#L39
#利用ctop查看docker容器的状态
wget https://githup.com/bcicen/ctop//download/v0.5/ctop-0.5-linux-amd64 -O ctop
mv ctop /usr/local/bin
chmod +x /usr/local/bin/ctop

ctop
#另一种查看方式 docker默认的stats
docker stats [OPTIONS] [CONTAINER...]
#查看所有容器运行状态
docker stats -a



#docker限制资源
#更新内存限制
docker update -m 2048m <name>

#docker 容器开机自动启动
docker run -m 512m --memory-swap 1G -it -p 58080:8080 --restart=always --name bvrfis --volumes-from logdata mytomcat:4.0 /root/run.sh
--restart具体参数值详细信息：
       no -  容器退出时，不重启容器；
       on-failure - 只有在非0状态退出时才从新启动容器；
       always - 无论退出状态是如何，都重启容器；
 #如果创建时未指定，可以通过update命令设置
 docker update --restart=always xxx
 
 
 
 
 #docker 创建镜像
 docker build -t myki:2018 -f Dockerfile.fwas-operations-admin .
 #docker 删除镜像
 docker rmi myki:2018
 
 #docker推送到githup
 docker tag java-zip-new:latest cheche/java-zip-new:20180706
 docker push cheche/java-zip-new:20180706
 
 #docker推送到阿里云私有库
 docker login --username=hi31813309@aliyun.com registry.cn-hangzhou.aliyuncs.com
 docker tag tomcat-8:latest registry.cn-hangzhou.aliyuncs.com/cheche/tomcat-8:20180706
 docker push registry.cn-hangzhou.aliyuncs.com/cheche/tomcat-8:20180706
 
 
 
 #docker 导出
 docker save -o java-zip.tar.gz java-zip
 #docker 导入
 docker load -i java-zip.tar.gz