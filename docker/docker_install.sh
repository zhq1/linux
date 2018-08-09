#备份系统原有yum源
mkdir -p /etc/yum.repos.d/backup/
mv -f /etc/yum.repos.d/* /etc/yum.repos.d/backup/  >/dev/null 2>&1
#替换阿里云yum源
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum clean all
yum makecache
#下载特定版本docker
#下载特定版本docker
wget https://mirrors.aliyun.com/docker-ce/linux/centos/7/x86_64/edge/Packages/docker-ce-17.06.2.ce-1.el7.centos.x86_64.rpm
#
