#!/usr/bin/env bash
war_dir=(`find . -name "*.war"`)
for i in ${war_dir[*]}
    do
        #app_dir=`echo "$i"|awk -F [.] '{print $2}'|sed -n 's/^\///p'`
        #app=`echo "$app_dir"|awk -F [/] '{print $NF}'`
        app_dir=${i#*./}
        app=`basename $i .war`
        if [ -f "Dockerfile.$app" ];then
            echo "Dockerfile.$app"
            continue
        else
            cat >> Dockerfile.$app << EOF
FROM registry.cn-hangzhou.aliyuncs.com/cheche/tomcat-8:20180822
#COPY $app_dir /data/tomcat/webapps/$app
ADD $app_dir /data/tomcat/webapps/
RUN source /etc/profile
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
ENV LANG zh_CN.UTF-8
EXPOSE 22 8080 
EOF
        echo "Dockerfile.$app"
        fi
done
