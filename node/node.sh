#node_install
下载源码 官网地址https://nodejs.org/en/download/
cd /usr/local/src/
wget http://nodejs.org/dist/v0.10.24/node-v0.10.24.tar.gz
#解压源码
tar -zxvf node-v0.10.24.tar.gz
#编译安装
cd node-v0.10.24/
./configure --prefix=/usr/local/node/0.10.24
make
make install
#配置NODE_HOME，进入profile编辑环境变量
vim /etc/profile
#set for nodejs
export NODE_HOME=/usr/local/node/0.10.24
export PATH=$NODE_HOME/bin:$PATH

source /etc/profile
node -v
#启动服务
node server.js