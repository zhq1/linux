#!/usr/bin/env bash
#获取192.168.2.4 /datawww/logs下面的文件到home下
rsync -av root@192.168.2.4:/data/wwwlogs /home
#上传/root/myki本地文件夹到192.168.2.4的/data下
rsync -av /root/myki root@192.168.2.4:/data/
