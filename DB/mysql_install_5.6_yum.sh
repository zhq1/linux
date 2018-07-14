rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum repolist enabled | grep "mysql.*-community.*"
yum -y install mysql-community-server
systemctl enable mysqld
systemctl start mysqld
重置密码
mysql_secure_installation
Set root password? [Y/n] y        [设置root用户密码]
Remove anonymous users? [Y/n] y            [删除匿名用户]
Disallow root login remotely? [Y/n] n            [禁止root远程登录]
Remove test database and access to it? [Y/n] y       [删除test数据库]
Reload privilege tables now? [Y/n] y        [刷新权限]
//登录MYSQL（有ROOT权限）。这里我以ROOT身份登录
[root@iZ28gvqe4biZ ~]# mysql -u root -p
//修改访问权限，让其他计算机也能访问
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'yourpassword' WITH GRANT OPTION;
//首先为用户创建一个数据库hivemeta
mysql  > create database test;
mysql  > use test
//授权hdp用户拥有hivemeta数据库的所有权限。
mysql  > grant all privileges on *.* to hdp@"%" identified by "hdp" with grant option;
//刷新系统权限表
mysql  > flush privileges;
mysql  > use test;
//mysql/hive字符集问题
mysql  > alter database test character set latin1;

测试连接......