#如果是创建镜像的时候
RUN yum -y install python-setuptools
RUN easy_install supervisor

CMD /usr/bin/supervisord -c /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

#守护进程语法
[supervisord]
nodaemon=true

[program:sshd]
command=/usr/sbin/sshd -D
autostart=true
autorestart=true

[program:redis]
command=/usr/local/bin/redis-server /etc/redis/redis.conf