#!/usr/bin/env bash
pid=`ps -ef | grep jenkins.war | grep -v 'grep'| awk '{print $2}'| wc -l`
if [ "$1" = "start" ];then
        if [ $pid -gt 0 ];then
    echo 'jenkins is running...'
    else
    java -jar /home/jenkins.war --httpPort=8090 >/dev/null 2>&1 &
        fi
elif [ "$1" = "stop" ];then
        exec ps -ef | grep jenkins | grep -v grep | awk '{print $2}'| xargs kill -9
    echo 'jenkins is stop..'
else
        echo "Please input like this:"./jenkins.sh start" or "./jenkins stop""
fi
