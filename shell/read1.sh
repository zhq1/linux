#!/bin/sh
#一次读文件一行
i=0
while read line
do
        echo $line
        let i=i+1
done < vosinfo
echo "$line"
