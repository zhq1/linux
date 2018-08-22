#centos 7添加tomcat开机自启
vi bin/catalina.sh

# Copy CATALINA_BASE from CATALINA_HOME if not already set  
[ -z "$CATALINA_BASE" ] && CATALINA_BASE="$CATALINA_HOME"  
# 设置pid。一定要加在CATALINA_BASE定义后面，要不然pid会生成到/下面  
CATALINA_PID="$CATALINA_BASE/tomcat.pid"  

vi /lib/systemd/system/tomcat.service 
[Unit]
Description=Tomcat
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking

Environment="JAVA_HOME=/usr/local/jdk1.8.0_121"

PIDFile=/opt/tomcat/tomcat.pid
ExecStart=/opt/tomcat/bin/startup.sh
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target




#修改tomcat.service文件后需要执行下面命令使其生效：
systemctl daemon-reload

启动tomcat服务

systemctl start tomcat.service
设置开机自启动

systemctl enable tomcat.service
停止开机自启动

systemctl disable tomcat.service
查看服务当前状态

systemctl status tomcat.service
重新启动服务

systemctl restart tomcat.service
查看所有已启动的服务

systemctl list-units --type=service