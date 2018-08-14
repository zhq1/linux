#centos 7 
vim /lib/systemd/system/docker.service
找到这一行：
ExecStart=/usr/bin/dockerd
修改为
ExecStart=/usr/bin/dockerd --graph=/data/docker
重启服务

systemctl daemon-reload
systemctl start docker