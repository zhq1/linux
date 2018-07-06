set -m
#设置jvm环境变量
source /etc/profile
JAVA_SET=""JAVA_OPTS='-Xms512m -Xmx512m -XX:PermSize=256M -XX:MaxPermSize=256M -Ddruid.registerToSysProperty=true'""
#设置容器资源配置
CONTAINER_MEM=1024m
CONTAINER_MEM_SWAP=1024m
CONTAINER_CPUSET=2,3,4,5
CONTAINER_CPUSHARE=4
#打包编译应用程序
cd ${WORKSPACE} 
mvn clean install -Dpackage.environment=dev -Dmave.test.skip=true -U
#创建Dockerfile
function createDockerfile_web() {
war_dir=(`find . -name "*.war"`)
for i in ${war_dir[*]}
    do
        #app_dir=`echo "$i"|awk -F [.] '{print $2}'|sed -n 's/^\///p'`
        #app=`echo "$app_dir"|awk -F [/] '{print $NF}'`
        app_dir=${i#*./}
        app=`basename $i .war`
    if [ "$1" == "$app" ];then
        if [ -f "Dockerfile.$app" ];then
            echo "Dockerfile.$app"
            break
        else
            cat >> Dockerfile.$app << EOF
FROM tomcat-8
#COPY $app_dir /data/tomcat/webapps/$app
ADD $app_dir /data/tomcat/webapps/
RUN source /etc/profile
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
ENV LANG zh_CN.UTF-8
EXPOSE 22 8080 
EOF
        echo "Dockerfile.$app"
        fi
    else
        continue
    fi
done
}
function createDockerfile_zip() {
war_dir=(`find . -name "*.zip"`)
for i in ${war_dir[*]}
    do
        #app_dir=`echo "$i"|awk -F [.] '{print $2}'|sed -n 's/^\///p'`
        #app=`echo "$app_dir"|awk -F [/] '{print $NF}'`
        app_dir=${i#*./}
        app=`basename $i .zip`
    if [ "$1" == "$app" ];then
        if [ -f "Dockerfile.$app" ];then
            echo "Dockerfile.$app"
            break
        else
            cat >> Dockerfile.$app << EOF
FROM java-zip
COPY $app_dir /data/jar/
RUN  source /etc/profile
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
ENV LANG zh_CN.UTF-8
EXPOSE 22 
EOF
        echo "Dockerfile.$app"
        fi
    else
        continue
    fi
done
}
#获取容器信息
function information () {
    LOCAL_IP=`ifconfig|grep 'inet'|grep "192.168"|awk '{print $2}'`
    PORT=`docker port $1 |awk -F [:] '/^8080/ {print $NF}'`
    echo ${LOCAL_IP}:${PORT}
}
#生成image和启动container
function avormall_web() {
    LOCATION_PATH=qmall
    LOG="/data/app_log/${LOCATION_PATH}"
    APP=qmall
    DOCKERFILE=`createDockerfile_web ${APP}`
    IMAGE_NAME=`echo mxgc-${LOCATION_PATH}|tr [A-Z] [a-z]`
    docker build -t ${IMAGE_NAME} -f ${DOCKERFILE} .
    if [ `docker ps -a|grep -v "NAME"|awk '{print $NF}'|grep -w ${IMAGE_NAME}|wc -l` -ne 0 ];then
        docker stop cadvisor
        docker rm -f ${IMAGE_NAME}
        docker start cadvisor
    fi
    docker run -d -P -p 32789:8080 --name=${IMAGE_NAME} \
    -v ${LOG}:/data/tomcat/logs/ -v /etc/localtime:/etc/localtime -c ${CONTAINER_CPUSHARE} -m=${CONTAINER_MEM} --memory-swap=1024m \
    --cpuset-cpus=${CONTAINER_CPUSET} -e "${JAVA_SET}" ${IMAGE_NAME}
    MSG=`information ${IMAGE_NAME}`
    #python /root/update_etcd.py ${IMAGE_NAME} ${LOCATION_PATH} ${MSG} ${APP}
}
function avormall_zip() {
    LOCATION_PATH=fsoa.favormall.provide-1.0.0-SNAPSHOT-bin
    LOG="/data/app_log/${LOCATION_PATH}"
    APP=fsoa.favormall.provide-1.0.0-SNAPSHOT-bin
    DOCKERFILE=`createDockerfile_zip ${APP}`
    IMAGE_NAME=`echo mxgc-${LOCATION_PATH}|tr [A-Z] [a-z]`
    docker build -t ${IMAGE_NAME} -f ${DOCKERFILE} .
    if [ `docker ps -a|grep -v "NAME"|awk '{print $NF}'|grep -w ${IMAGE_NAME}|wc -l` -ne 0 ];then
        docker stop cadvisor
        docker rm -f ${IMAGE_NAME}
        docker start cadvisor
    fi
    docker run -d -P -p 21009:21009 --name=${IMAGE_NAME} \
    -v ${LOG}:/data/app_log/ -v /etc/localtime:/etc/localtime -c ${CONTAINER_CPUSHARE} -m=${CONTAINER_MEM} --memory-swap=1024m \
    --cpuset-cpus=${CONTAINER_CPUSET} -e "${JAVA_SET}" ${IMAGE_NAME} 
    #MSG=`information ${IMAGE_NAME}`
    docker exec mxgc-fsoa.favormall.provide-1.0.0-snapshot-bin /bin/bash -c "echo -e 192.168.2.249  \$HOSTNAME > /etc/hosts"
    #python /root/update_etcd.py ${IMAGE_NAME} ${LOCATION_PATH} ${MSG} ${APP}
}
case $Application in
avormall-web)
    avormall_web
;;
avormall-zip)
    avormall_zip
;;
all)
    avormall_web
    avormall_zip
;;
esac
