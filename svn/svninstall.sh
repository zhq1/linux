centos6.5安装svn
#yum安装svn服务
yum install subversion
#查看svn rpm包版本
rpm -ql subversion
#查看svn版本
/usr/bin/svnersion --version
#创建svn版本库目录
mkdir -p /var/svn/svnrepos
#创建版本库
svnadmin create /var/svn/svnrepos
cd /var/svn/svnrepos/conf/
#编辑svn用户账户
vi passwd
cheche=xiaofan@1
#编辑svn用户权限
vi authz
[/]
cheche=rw
#编辑svn服务配置文件
vi svnserver.conf
#匿名用户可读
anon-access = read
#开启查看日志
anon-access = none
#授权用户可写
auth-access = write
#使用哪个文件夹作为账号文件
password-db = passwd
使用哪个文件作为权限文件
authz-db = authz
#认证空间名，版本库所在目录
realm = /var/svn/svnrepos
#svn启动命令
svnserve -d -r /var/svn/svnrepos

No.1 将准备要迁移的仓库导出 命令： svnadmin dump 仓库名 > svn_dump
No.2 在新的服务器上创建心的仓库 命令： svnadmin create SVNROOT
No.3 导入刚导出的文件svn_dump 命令： svnadmin load SVNROOT < svn_dump
