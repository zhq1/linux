#jenkins搭建
#官网下载地址：http://mirrors.jenkins.io/war-stable/latest/jenkins.war　
#下载jdk
wget https://1nth.oss-cn-beijing.aliyuncs.com/jdk-8u121-linux-x64.tar.gz
#下载maven
wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
tar -zxvf *.tar.gz -C /usr/local/

#全局变量
vim /etc/profile

#java环境变量
JAVA_HOME=/usr/local/jdk1.8.0_121
JRE_HOME=$JAVA_HOME/jre
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
CLASSPATH=:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib/dt.jar
export JAVA_HOME JRE_HOME PATH CLASSPAT

#maver环境变量
MAVEN_HOME=/usr/local/apache-maven-3.5.4
export MAVEN_HOME  
export PATH=${PATH}:${MAVEN_HOME}/bin
 
java -version
maven -version
 


wget https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/2.121.1/jenkins.war 
#java -jar jenkins.war --ajp13Port=-1 --httpPort=8090
#启动命令
#建议用此命令定制一些参数
nohup java -Dcom.sun.akuma.Daemon=daemonized -Djava.awt.headless=true -DJENKINS_HOME=/home/data/jenkins -jar /home/data/soft/jenkins.war --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war --daemon --httpPort=8080 --debug=5 --handlerCountMax=100 --handlerCountMaxIdle=20 /dev/null 2>&1 &

#./jenkins_service.sh start 






#梦想工厂
#解压jdk&tomcat
tar -xvf jdk-8u101-linux-x64.tar.gz -C /usr/local/
tar -xvf apache-tomcat-7.0.72.tar.gz -C /usr/local/
mv jdk1.8.0_101/ java
mv apache-tomcat-7.0.72/ tomcat

#配置环境变量
#set java environment
JAVA_HOME=/usr/local/java
JRE_HOME=/usr/local/java/jre
PATH=\$JAVA_HOME/bin:\$PATH:$HOME/bin
CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar


#下载jenkins.war
wget http://mirrors.jenkins.io/war/latest/jenkins.war

mv jenkins.war /usr/local/tomcat/webapps/
#web登陆ip:8080/jenkins
#密码参看
cat /root/.jenkins/secrets/initialAdminPassword 




jenkins从节点安装
tar -xvzf jdk1.8.0_91.tar.gz -C /usr/local/
tar -xvzf apache-maven-3.5.2.tar.gz -C /usr/local/
cd /usr/local/
mv jdk1.8.0_91/ java
vi /etc/profile
#maven path
export MAVEN_HOME=/usr/local/apache-maven-3.5.2
#java path
export JAVA_HOME=/usr/local/java
export PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
#history path
export PROMPT_COMMAND='{ msg=vi /etc/docker/daemon.json$(history 1|{ read x y;echo $y; } );logger "[euid=$(whoami)]":$(who am i):[`pwd`]"$msg";}'
export TMOUT=600
HISTFILESIZE=10000

#安装docker
yum localinstall *.rpm
systemctl start docker
vi /etc/docker/daemon.json
{"graph": "/home/data/docker"}
systemctl restart docker
dd if=/dev/zero of=/home/data/docker/devicemapper/devicemapper/data bs=1G count=0 seek=5120
dd if=/dev/zero of=/home/data/docker/devicemapper/devicemapper/metadata bs=1G count=0 seek=20
systemctl restart docker

#安装git
yum install -y git

#安装node
wget http://nodejs.org/dist/v8.9.3/node-v8.9.3-linux-x64.tar.gz
ln -s /usr/local/node-v8.9.3-linux-x64/bin/node /usr/bin/node
ln -s /usr/local/node-v8.9.3-linux-x64/bin/npm /usr/bin/npm
docker load < tomcat-8.tar
docker load < java-zip.tar


