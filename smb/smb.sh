#linux搭建smb测试
#公司打印机扫描太多，并且存储有限，故搭建smb用于共享
#安装sbm服务以及客户端
yum -y install samba samba-client
#进入smb配置文件夹下
cd /etc/samba/
#保存默认配置
cp smb.conf smb.conf.bak
#修改smb配置文件
vi smb.conf
#WORKGROUP要与WIN工作组一致
[global]
        workgroup = WORKGROUP
        server string = Ted Samba Server %v
        netbios name = TedSamba
        security = user
        map to guest = Bad User
        passdb backend = tdbsam
#共享文件夹，匿名、公开、可写
[FileShare]
        comment = share some files
        path = /smb/fileshare
        public = yes
        writeable = yes
        create mask = 0644
        directory mask = 0755
#限定ted用户访问
[WebDev]
        comment = project development directory
        path = /smb/webdev
        valid users = ted
        write list = ted
        printable = no
        create mask = 0644
        directory mask = 0755

#创建用户组
groupadd co3

#添加ted用户
useradd ted -g co3 -s /sbin/nologin

#增加ted的smb密码
smbpasswd -a ted

#创建共享目录
mkdir -p /smb/{fileshare,webdev}

#授权目录访问权限
chown nobody:nobody /smb/fileshare/
chown ted:co3 /smb/webdev/

#启动smb
systemctl start smb
#开机启动smb
systemctl enable smb

#防火墙要开启端口
firewall-cmd --permanent --add-port=139/tcp
firewall-cmd --permanent --add-port=445/tcp
systemctl restart firewalld



#如果是linux访问配置需要修改
vim /etc/samba/smb.conf
[global]        
        workgroup = WORKGROUP
        server string = Samba Server Version %v
        netbios name = MYSERVER
        security = user
        passdb backend = tdbsam

[tvms]
        path = /root/tvms-test
        public = yes
        valid user = root
        writeable = yes
        printable = no
        create mask = 0644
        directory mask = 0755

		
#linux 挂载smb
mkdir /mnt/tvms
mount //192.168.118.133/tvms /mnt/tvms

#永久挂载
vi /etc/fstab
//192.168.118.133/tvms  /mnt/tvms               cifs    defaults,username=root,password=1       0 0
