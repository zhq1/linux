vi /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1

sysctl -p
执行sysctl -p 时出现：
[root@localhost ~]# sysctl -p
sysctl: cannot stat /proc/sys/net/bridge/bridge-nf-call-ip6tables: No such file or directory
sysctl: cannot stat /proc/sys/net/bridge/bridge-nf-call-iptables: No such file or directory

解决方法：
[root@localhost ~]# modprobe br_netfilter
[root@localhost ~]# ls /proc/sys/net/bridge
bridge-nf-call-arptables bridge-nf-filter-pppoe-tagged
bridge-nf-call-ip6tables bridge-nf-filter-vlan-tagged
bridge-nf-call-iptables bridge-nf-pass-vlan-input-dev

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
#安装docker
yum localinstall docker-ce-17.06.2.ce-1.el7.centos.x86_64.rpm  -y


#centos 7 
vim /lib/systemd/system/docker.service
找到这一行：
ExecStart=/usr/bin/dockerd
修改为
ExecStart=/usr/bin/dockerd --graph=/data/docker


#因为docker镜像被墙所以配置加速器
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://9mmj7d8t.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker



#阿里云docker ce 文档
#官方自动安装脚本
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
#CentOS 7 (使用yum进行安装)
# step 1: 安装必要的一些系统工具
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# Step 2: 添加软件源信息
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# Step 3: 更新并安装 Docker-CE
sudo yum makecache fast
sudo yum -y install docker-ce
# Step 4: 开启Docker服务
sudo service docker start
# 注意：
# 官方软件源默认启用了最新的软件，您可以通过编辑软件源的方式获取各个版本的软件包。例如官方并没有将测试版本的软件源置为可用，你可以通过以下方式开启。同理可以开启各种测试版本等。
# vim /etc/yum.repos.d/docker-ce.repo
#   将 [docker-ce-test] 下方的 enabled=0 修改为 enabled=1
#
# 安装指定版本的Docker-CE:
# Step 1: 查找Docker-CE的版本:
# yum list docker-ce.x86_64 --showduplicates | sort -r
#   Loading mirror speeds from cached hostfile
#   Loaded plugins: branch, fastestmirror, langpacks
#   docker-ce.x86_64            17.03.1.ce-1.el7.centos            docker-ce-stable
#   docker-ce.x86_64            17.03.1.ce-1.el7.centos            @docker-ce-stable
#   docker-ce.x86_64            17.03.0.ce-1.el7.centos            docker-ce-stable
#   Available Packages
# Step2 : 安装指定版本的Docker-CE: (VERSION 例如上面的 17.03.0.ce.1-1.el7.centos)
# sudo yum -y install docker-ce-[VERSION]

#安装校验
docker version