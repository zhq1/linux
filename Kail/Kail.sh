1.vi /etc/ssh/sshd_config
2.将#PasswordAuthentication no的注释去掉，并且将NO修改为YES //kali中默认是yes
3.将PermitRootLogin without-password 修改为 PermitRootLogin yes
4.然后，保存，退出vim。
5.启动SSH服务
5.1命令为：/etc/init.d/ssh start
或者 service ssh start
5.2查看SSH服务状态是否正常运行，命令为：/etc/init.d/ssh status
或者service ssh status