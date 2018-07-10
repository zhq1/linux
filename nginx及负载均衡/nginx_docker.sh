#利用docker测试nginx负载均衡
#系统centos 7.x——64
#创建yum备份文件夹
mkdir -p /etc/yum.repos.d/backup/
#备份系统原有yum源（作为运维要养成随手备份习惯）
mv -f /etc/yum.repos.d/* /etc/yum.repos.d/backup/  >/dev/null 2>&1
#使用阿里云yum源
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum clean all
yum makecache
#下载docker特定版本
wget https://mirrors.aliyun.com/docker-ce/linux/centos/7/x86_64/edge/Packages/docker-ce-17.06.2.ce-1.el7.centos.x86_64.rpm
#yum安装docker 17.06
yum localinstall docker-ce-17.06.2.ce-1.el7.centos.x86_64.rpm -y
#启动docker
systemctl restart docker
#配置镜像加速器 下载docker镜像更快，要不然是龟速
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://9mmj7d8t.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
#docker拉取nginx镜像
docker pull nginx
mkdir -p /mydata/test1
mkdir -p /mydata/test2
vim /mydata/test1/index.html
nginx1
vim /mydata/test2/index.html
nginx2
#启动两个镜像
docker run --name nginx-test -d -p 8080:80 -v /mydata/test1:/usr/share/nginx/html nginx
docker run --name nginx-test1 -d -p 8081:80 -v /mydata/test2:/usr/share/nginx/html nginx

yum install -y nginx
#安装之后就可以测试nginx的几种负载
1、轮询（默认）2、weight 3、ip_hash 4、fair（第三方）5、url_hash（第三方）

#下面给出一个实例
vim /etc/nginx/nginx.conf
http{
    upstream web_servers1 {
                server 127.0.0.1:8080 weight=1;
                server 127.0.0.1:8081 weight=1;
    }
        location / {
                root    /usr/share/nginx/html;
                index   index.html indes.htm;
                proxy_pass      http://web_servers1;
                
}
