官网下载地址：http://mirrors.jenkins.io/war-stable/latest/jenkins.war
java -jar jenkins.war　
wget jdk-8u121-linux-x64.tar.gz
wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
tar -zxvf *.tar.gz -C /usr/local/
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
nohup java -Dcom.sun.akuma.Daemon=daemonized -Djava.awt.headless=true -DJENKINS_HOME=/home/data/jenkins -jar /home/data/soft/jenkins.war --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war --daemon --httpPort=8080 --debug=5 --handlerCountMax=100 --handlerCountMaxIdle=20 /dev/null 2>&1 &

./jenkins_service.sh start 