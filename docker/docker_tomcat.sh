#tomcat 在docker里面运行
#从阿里云私有仓库下载tomcat镜像
docker pull registry.cn-hangzhou.aliyuncs.com/cheche/tomcat-8:20180822
#修改doker镜像名字
docker tag 72515f5952c9 tomcat-8:least
#创建dockerfile文件

cat Dockerfile.helloworld
FROM tomcat-8:least
#COPY $app_dir /data/tomcat/webapps/$app
ADD helloworld.war /data/tomcat/webapps/
RUN source /etc/profile
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
ENV LANG zh_CN.UTF-8
EXPOSE 22 8080 


#创建images
docker build -t helloworld:`date +"%Y%m%d%H%M"` -f Dockerfile.helloworld .

#运行容器
docker run -d -P -p 8080:8080 --name=helloworld -v /opt/logs:/data/app_log/ -v /etc/localtime:/etc/localtime  helloworld