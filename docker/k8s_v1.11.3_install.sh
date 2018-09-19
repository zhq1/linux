

-----------------k8s 1.11.3 HA离线安装----------------------

## 1，修改主机名/ssh/绑定主机名 免密钥登录
   hostnamectl set-hostname  #注意：主机名，不能用特殊符号(比如：jmsw-xx.hnser.com)，可直接(node1)这种就可以。
   vim /etc/hosts     #绑定主机名
   ##vim .ssh/authorized_keys  #创建免密钥登录 “可不用”



## 2, 升级内核
   rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm ;yum --enablerepo=elrepo-kernel install  kernel-lt-devel kernel-lt -y
   #查看默认启动顺序
   [commond:]# awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg

      CentOS Linux (4.4.4-1.el7.elrepo.x86_64) 7 (Core)
      CentOS Linux (3.10.0-327.10.1.el7.x86_64) 7 (Core)
      CentOS Linux (0-rescue-c52097a1078c403da03b8eddeac5080b) 7 (Core)

   #默认启动的顺序是从0开始，新内核是从头插入（目前位置在0，而4.4.4的是在1），所以需要选择0。
   [commond:]# grub2-set-default 0
   #重启
   [commond:]# reboot
   #检查内核，成功升级到4.4
   [commond:]# uname -a
      Linux bigdata5 4.4.104-1.el7.elrepo.x86_64 #1 SMP Tue Dec 5 12:46:32 EST 2017 x86_64 x86_64 x86_64 GNU/Linux



## 3，虚拟机修改网卡名  ----如果是eth0 名就不需要修改(注意：可不用执行此步骤)
## 编辑/etc/default/grub文件内容，增加“net.ifnames=0 biosdevname=0”

GRUB_CMDLINE_LINUX="crashkernel=auto net.ifnames=0 biosdevname=0 rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet"
grub2-mkconfig -o /boot/grub2/grub.cfg

mv /etc/sysconfig/network-scripts/ifcfg-ens33  /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i "s/ens33/eth0/g" /etc/sysconfig/network-scripts/ifcfg-eth0
cat /etc/sysconfig/network-scripts/ifcfg-eth0
reboot



## 4，执行优化脚本/拷贝相关文件都执行服务器
### 把已经下载好的kube1.11.3.tar.gz 版本/脚本init.sh /配置文件keepalived.conf check_haproxy.sh ---》拷贝到服务器的相关目录下
   cd ~
   sh init.sh
   reboot
   curl https://quay.io
   cp keepalived.conf check_haproxy.sh /etc/keepalived   ---》#覆盖自带的
   systemctl enable keepalived && systemctl start keepalived && systemctl status keepalived



## 5，安装 docker (所有server)
### https://docs.docker.com/install/linux/docker-ce/centos/#install-docker-ce-1  官网install
# 安装 yum-config-manager
    yum install -y yum-utils device-mapper-persistent-data lvm2 yum-plugin-ovl
# 导入
   yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# 更新 repo
   yum makecache && yum list docker-ce.x86_64  --showduplicates |sort -r
   yum install -y docker-ce      #18.03版本默认 文件系统为ovelay2驱动
   systemctl enable docker && systemctl start docker && systemctl status docker



## 6，拉取镜像/进入容器
   docker run --rm -v /data/kube1.11.3.tar.gz:/data/kube1.11.3.tar.gz -it -w /etc/ansible fanux/sealos:latest bash


## 7，在容器里---》创建免密钥登录/将密钥拷贝到各安装服务器上
   mkdir ~/.ssh
   cd ~/.ssh
   ssh-keygen -t rsa
   cat ~/.ssh/id_rsa.pub

## 8，在容器里---》修改的ansible/hosts文件/把IP、name、VIP换成自己服务器的/1.11.1改成1.11.3
   cd /etc/ansible/
   vi hosts


## 9，在容器里---》执行install 等待结果.....
   ansible-playbook roles/install-all.yaml


## 10，在容器里---》install 失败执行
   ansible-playbook roles/uninstall-all.yaml
   kubeadm reset
   rm -rf ~/.kube/ && rm -rf /etc/kubernetes/ && rm -rf /etc/systemd/system/kubelet.service.d && rm -rf /etc/systemd/system/kubelet.service && rm -rf /usr/bin/kube*
   rm -rf /etc/cni && rm -rf /opt/cni && rm -rf /var/lib/etcd && rm -rf /var/etcd



## 11，验证dashboard/监控平台
   https://server_ip:32000
   http://server_ip:32001


## 12，如果需要节点执行kubectl get 相关命令
   把 master 文件拷贝到各节点
   scp -r .kube 192.168.xxx:/root


#注意：
   节点报错：file_linux.go:61] Unable to read config path "/etc/kubernetes/manifests": path does not exist, ignoring
   解决办法：mkdir -p /etc/kubernetes/manifests

   重启命令：
   swapoff -a&& setenforce 0&&systemctl start kubelet
   etcdctl cluster-healthy

#coreDNS默认安装
