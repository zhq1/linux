yum install gcc openldap-devel pam-devel openssl-devel
wget http://jaist.dl.sourceforge.net/project/ss5/ss5/3.8.9-8/ss5-3.8.9-8.tar.gz
tar -zxvf ss5-3.8.9-8.tar.gz
cd ss5-3.8.9
./configure
make
make install
vim /etc/opt/ss5/ss5.conf
permit u        0.0.0.0/0       -       0.0.0.0/0       -       -       -       -       -
auth    0.0.0.0/0               -               u

vim etc/opt/ss5/ss5.passwd
fanchaofan f******8



chmod a+x /etc/init.d/ss5
service ss5 start
#socks5代理软件安装
