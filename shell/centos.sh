#centos 7开机启动
chmod +x /etc/rc.d/rc.local
vi /opt/init.sh
#!/usr/bin/env bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv

chmod +x /opt/init.sh

hostnamectl set-hostname  test  #修改主机名
nohup python -m SimpleHTTPServer 8001 &   #启动一个http
#把文件夹1并且附带文件夹1拷贝到2（1和2都是文件夹）
cp -dprf 1 2
#把文件3拷贝到2下面
cp -dprf 3 2
#把1文件夹下面的文件不附带文件夹1拷贝到2
cp -dprf 1/* 2/
cp -dprf 1/ 2/

#执行一次的命令
at 14:25 08/31/2018
at> sed -i '267s/#//' nginx.conf
Ctrl+D
替换267行的#为空

chmod 4755 /usr/bin/sudo

su - webadm -c "echo 123 > /opt/logs/test.log"
su - kunshiweb -c "export JAVA_OPTS=-Xmx2048m;cd $TOMCAT_HOME/bin;$TOMCAT_HOME/bin/$TOMCAT_START >/dev/null 2>&1 &"