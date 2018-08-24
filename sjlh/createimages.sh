#!/usr/bin/env bash
war_dir=(`find . -name "*.war"`)
for i in ${war_dir[*]}
    do
        #app_dir=`echo "$i"|awk -F [.] '{print $2}'|sed -n 's/^\///p'`
        #app=`echo "$app_dir"|awk -F [/] '{print $NF}'`
        app_dir=${i#*./}
        app=`basename $i .war`
	docker build -t $app:`date +"%Y%m%d%H%M"` -f Dockerfile.$app .
done
