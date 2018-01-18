#!/bin/bash

#初始化

LOGS_PATH=/var/log/haproxy

YESTERDAY=$(date -d "yesterday" +%Y%m%d)

#按天切割日志

cp ${LOGS_PATH}/haproxy.log ${LOGS_PATH}/haproxy_${YESTERDAY}.log

#进行打包

cd ${LOGS_PATH}

tar -zcvf haproxy_${YESTERDAY}.log.tar.gz haproxy_${YESTERDAY}.log --remove-files

#清空原来的日志文件

cd ${LOGS_PATH}

>haproxy.log

#删除7天前的日志

cd ${LOGS_PATH}

find . -mtime +90 -name "*20[1-9][3-9]*" | xargs rm -f

#或者

#find . -mtime +90 -name "ilanni.com_*" | xargs rm -f

exit 0
