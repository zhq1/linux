#!/bin/bash
#获取内网IP
inner=$(hostname -I)
#echo -e "内网IP:"$output $inner
 
#获取外网IP
outer=$(curl -s http://ipecho.net/plain)
#echo -e "外网IP:"$output $outer

#服务状态
for i in nginx mysql rabbit mongo
do
ps -ef | grep $i | grep -v grep 1>/dev/null 2>&1
if [ $? -eq 0 ]
then
echo "$i ip $inner：OK"
else
echo "$i ip $inner：NG"
fi
done
