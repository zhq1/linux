#!/bin/bash



#获取内网IP
inner=$(hostname -I)
#echo -e "内网IP:"$output $inner

#获取外网IP
outer=$(curl -s http://ipecho.net/plain)
#echo -e "外网IP:"$output $outer



#nginx服务

ps -ef | grep nginx | grep -v grep 1>/dev/null 2>&1
if [ $? -ne 0 ]
then
/sbin/service nginx start 1>/dev/null 2>&1
fi

#rabbitmq服务
ps -ef | grep rabbitmq | grep -v grep 1>/dev/null 2>&1
if [ $? -ne 0 ]
then
/sbin/service rabbitmq-server start 1>/dev/null 2>&1
fi

#前置服务
netstat -antlp | grep :1101 1>/dev/null 2>&1
if [ $? -ne 0 ]
then 
#/usr/local/java/bin/java -jar /usr/local/app/inceptor/sicdt-box-inceptor-web.jar &
/bin/bash   /usr/local/app/inceptor/go.sh
sleep 20
fi

#提取服务
netstat -antlp | grep :1102 1>/dev/null 2>&1
if [ $? -ne 0 ]
then 
#/usr/local/java/bin/java -jar /usr/local/app/extract/sicdt-box-preservation-extract-service.jar &
/bin/bash /usr/local/app/extract/go.sh
sleep 20
fi

#存证服务
netstat -antlp | grep :1103 1>/dev/null 2>&1
if [ $? -ne 0 ]
then 
#/usr/local/java/bin/java -jar /usr/local/app/save/sicdt-box-preservation-save-service.jar &
/bin/bash /usr/local/app/save/go.sh
sleep 20
fi

#web服务
netstat -antlp | grep :1104 1>/dev/null 2>&1
if [ $? -ne 0 ]
then 
#/usr/local/java/bin/java -jar /usr/local/app/web/sicdt-box-preservation-web.jar &
/bin/bash /usr/local/app/web/go.sh
sleep 20
fi


#job服务
netstat -antlp | grep :1203 1>/dev/null 2>&1
if [ $? -ne 0 ]
then 
#/usr/local/java/bin/java -jar /usr/local/app/job/sicdt-job-box.jar &
/bin/bash /usr/local/app/job/go.sh
sleep 20
fi
