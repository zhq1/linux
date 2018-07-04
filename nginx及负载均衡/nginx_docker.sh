docker pull nginx
mkdir -p /mydata/test1
mkdir -p /mydata/test2
vim /mydata/test1/index.html
vim /mydata/test2/index.html
docker run --name nginx-test -d -p 8080:80 -v /mydata/test1:/usr/share/nginx/html nginx
docker run --name nginx-test1 -d -p 8081:80 -v /mydata/test2:/usr/share/nginx/html nginx
yum install -y nginx
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
