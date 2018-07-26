#安装测试
yum install readline-devel pcre-devel openssl-devel gcc perl
wget https://openresty.org/download/openresty-1.13.6.1.tar.gz
tar -zxvf openresty-1.13.6.1.tar.gz
cd openresty-1.13.6.1/bundle
wget http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz
tar -zxvf ngx_cache_purge-2.3.tar.gz
wget https://github.com/yaoweibin/nginx_upstream_check_module/archive/v0.3.0.tar.gz
tar -zxvf v0.3.0.tar.gz
# ./configure --help可查询需要安装的模块
./configure --prefix=/usr/local/openresty --with-luajit --with-http_ssl_module --user=root --group=root --with-http_realip_module --add-module=./bundle/ngx_cache_purge-2.3/ --add-module=./bundle/nginx_upstream_check_module-0.3.0/
#编译安装
make -j2 && make install
#制作证书
mkdir -p /usr/local/openresty/nginx/cert
cd /usr/local/openresty/nginx/cert
openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
#修改nginx.conf
...
lua_package_path '/usr/local/openresty/lualib/?.lua;/usr/local/openresty/nginx/lua/?.lua;;'; #lua文件默认路径
lua_package_cpath '/usr/local/openresty/lualib/?.so;;'; #so文件默认路径
...
server {
    listen       192.168.0.100:8080;
    listen       192.168.0.100:8443 ssl;
    server_name  localhost;

    ssl_certificate /usr/local/openresty/nginx/cert/server.crt;
    ssl_certificate_key /usr/local/openresty/nginx/cert/server.key;
    ...
    ...
    ...
}

#启动nginx
/usr/local/openresty/nginx/sbin/nginx

#添加开机启动
cat >/usr/lib/systemd/system/nginx.service <<EOF
[Unit]
Description=nginx - high performance web server
Documentation=http://nginx.org/en/docs/
After=network.target

[Service]
Type=forking
PIDFile=/usr/local/openresty/nginx/logs/nginx.pid
ExecStartPre=/usr/local/openresty/nginx/sbin/nginx -t
ExecStart=/usr/local/openresty/nginx/sbin/nginx
ExecReload=/usr/local/openresty/nginx/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

#systemctl start nginx.service
systemctl enable nginx.service
#关闭防火墙
systemctl stop firewalld
systemctl disable firewalld


#在nginx.conf添加vhost配置
stream {


#    log_format hdm '$remote_addr [$time_local] $protocol $status $bytes_sent $bytes_received $session_time "$upstream_addr" "$upstream_bytes_sent" "$upstream_bytes_received" "$upstream_connect_time"';

#    access_log /var/log/nginx/tcp-access.log main ;
#    open_log_file_cache off;
     include vhost-tcp/*;
}

mkdir vhost-tcp/
cat mxgcco-release-sl-mysql
  upstream    mxgcco-release-sl-mysql  {
        server  192.168.2.4:8083;
  }
  server {
      listen 12640;
      proxy_connect_timeout 1m;
      proxy_timeout 5m;
      proxy_pass  mxgcco-release-sl-mysql;
  }

