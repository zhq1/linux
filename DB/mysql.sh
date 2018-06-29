#查看mysql用户
use mysql;
select user,host,password from user;
#修改密码
update user set password=password('123456') where user='root' and host='localhost';
set password for root@localhost = password('123');
mysqladmin -uroot -p123456 password 123  
