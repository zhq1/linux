1.要登录的远程用户的同名账户
如要用A机 test用户登录，则输入下列命令

adduser test

2.切换用户
su test

3.生成密钥对
ssh-keygen -t rsa
一路回车

4.拷贝公钥到远程linux即A机
在B机执行命令

scp ~/.ssh/id_rsa.pub webadm@192.168.1.45:~/.ssh/

在A机执行命令(test用户执行)

cat ~/.ssh/id_rsa.pub >> authorized_keys

chmod 600 authorized_keys

在B机进行登录(test用户)

ssh webadm@192.168.1.45

即可无密码登录到A系统