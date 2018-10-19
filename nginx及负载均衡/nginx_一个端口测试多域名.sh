#环境centos 7.4 64 
yum install -y epel-release
yum install -y nginx
cat /etc/sysctl.conf
mkdir /home/8001
mkdir /home/8002
cd /home/8001
python -m SimpleHTTPServer 8001 &
echo 8001 > index.html
mkdir /home/8002
python -m SimpleHTTPServer 8002 &
echo 8002 > index.html

curl http://localhost:8001
curl http://localhost:8002

vi /etc/nginx/nginx.conf
    server {
        listen       80 ;
        server_name  1.womaoapp.com;
        large_client_header_buffers 4 16k;
        client_max_body_size 300m;
        client_body_buffer_size 128k;
        proxy_connect_timeout 600;
        proxy_read_timeout 600;
        proxy_send_timeout 600;
        proxy_buffer_size 64k;
        proxy_buffers   4 32k;
        proxy_busy_buffers_size 64k;
        proxy_temp_file_write_size 64k;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;
         location / {
               proxy_pass http://10.200.221.212:8001;
               proxy_set_header Host  1.womaoapp.com;
               proxy_set_header   X-Real-IP        $remote_addr;
               proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
               proxy_set_header Cookie $http_cookie;
               log_subrequest on;
               proxy_cookie_path / /;
               proxy_set_header Cookie $http_cookie;
         }

    }
    server {
        listen       80 ;
        server_name  2.womaoapp.com;
        large_client_header_buffers 4 16k;
        client_max_body_size 300m;
        client_body_buffer_size 128k;
        proxy_connect_timeout 600;
        proxy_read_timeout 600;
        proxy_send_timeout 600;
        proxy_buffer_size 64k;
        proxy_buffers   4 32k;
        proxy_busy_buffers_size 64k;
        proxy_temp_file_write_size 64k;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;
         location / {
               proxy_pass http://10.200.221.212:8002;
               proxy_set_header Host  2.womaoapp.com;
               proxy_set_header   X-Real-IP        $remote_addr;
               proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
               proxy_set_header Cookie $http_cookie;
               log_subrequest on;
               proxy_cookie_path / /;
               proxy_set_header Cookie $http_cookie;
         }

    }
	
	
nginx -t
systemctl start nginx	
	
curl 1.womaoapp.com
curl 2.womaoapp.com