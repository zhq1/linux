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
 
 
java -jar jenkins.war --ajp13Port=-1 --httpPort=8090
