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
