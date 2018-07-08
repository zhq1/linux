#获取公网ip
#Go语言初体验 - 获取公网IP小服务。由于免费的动态dns刷新IP很慢， 手动实时获取办公室网络公网IP。

#GetIp.go 是服务端程序, 用于返回当前访问的请求的公网IP。 demo地址： http://47.52.66.195:56667/
#IpPush.go 是客户端程序, 用户请求IpPush（用Ngrok内网穿透暴露服务地址）会访问上面的GetIp服务, 并将获取到的IP返回。demo: http://acloud.s1.natapp.cc/



wget https://github.com/liuhu/PublicIpServer/raw/master/GetIp.go
wget https://github.com/liuhu/PublicIpServer/raw/master/IpPush.go


yum install -y go
go run Getip.go &
