#查找docker ip
docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
#提交新的镜像
docker commit c3f279d17e0a  tomcat-8
#启动系统所有镜像
docker start $(docker ps -a -q)
