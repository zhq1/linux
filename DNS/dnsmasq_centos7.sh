yum install dnsmasq -y
#dnsmasq配置文件
cat /etc/dnsmasq.conf
# 上游 DNS 定义
resolv-file=/etc/resolv.dnsmasq.conf
# 取消从本地 hosts 读取
no-hosts
# 监听地址
listen-address=127.0.0.1,192.168.2.6
# 指定本地 dns host 配置
addn-hosts=/etc/dnsmasq.hosts
# 设置 dns 缓存大小
cache-size=150
# set log 
log-facility=/var/log/dnsmasq/dnsmasq.log
log-queries

#上游DNS配置文件
cat /etc/resolv.dnsmasq.conf
nameserver 201.106.196.115
nameserver 202.106.0.20
nameserver 8.8.8.8


#本地域名解析配置文件
cat /etc/dnsmasq.hosts
#exanple
#192.168.2.5 svn.mxgcco.com
192.168.2.80 svn.mxgcco.com
192.168.2.1  devjenkins.mxgcco.com
192.168.2.1  wangkang.mxgcco.com
192.168.2.1  nexus.mxgcco.com
192.168.2.1  qazabbix.mxgcco.com
192.168.2.1  deves.mxgcco.com
192.168.2.1  doclever.mxgcco.com
192.168.2.1  phab.mxgcco.com
192.168.2.1  jump.mxgcco.com
192.168.2.5  git.mxgcco.com
192.168.2.1  dev.womaoapp.com
192.168.2.1  dev-dubbo.mxgcco.com
192.168.2.1  dev.wogeapp.com
192.168.2.1  dev.mxgcco.com
192.168.2.1  dev.2099co.com
192.168.2.1  devxxl.mxgcco.com
192.168.2.1  chandao.mxgcco.com
49.4.5.249  qazookeeper.mxgcco.com
192.168.2.1  dev.engine.womaoapp.com
192.168.2.1  dev.business.womaoapp.com
192.168.2.6  dev-sensitiveword.wogeapp.com


