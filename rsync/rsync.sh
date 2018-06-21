#!/usr/bin/env bash
#获取192.168.2.4 /datawww/logs下面的文件到home下
rsync -av root@192.168.2.4:/data/wwwlogs /home
