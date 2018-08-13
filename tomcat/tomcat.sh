vi /etc/profile

#java path
export JAVA_HOME=/usr/local/java
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
##########first tomcat###########
CATALINA_BASE=/usr/local/tomcat
CATALINA_HOME=/usr/local/tomcat
TOMCAT_HOME=/usr/local/tomcat
export CATALINA_BASE CATALINA_HOME TOMCAT_HOME
##########first tomcat############
##########second tomcat##########
CATALINA_2_BASE=/usr/local/tomcat_2
CATALINA_2_HOME=/usr/local/tomcat_2
TOMCAT_2_HOME=/usr/local/tomcat_2
export CATALINA_2_BASE CATALINA_2_HOME TOMCAT_2_HOME
##########second tomcat##########

source /etc/profile


vim catalina.sh

export CATALINA_HOME=$CATALINA_2_HOME
export CATALINA_BASE=$CATALINA_2_BASE



打开server.xml更改端口：
修改server.xml配置和第一个不同的启动、关闭监听端口。
修改后示例如下：
　 <Server port="9005" shutdown="SHUTDOWN">　               端口：8005->9005
<!-- Define a non-SSL HTTP/1.1 Connector on port 8080 -->
    <Connector port="9080" maxHttpHeaderSize="8192"　       端口：8080->9080
maxThreads="150" minSpareThreads="25" maxSpareThreads="75"
               enableLookups="false" redirectPort="8443" acceptCount="100"
               connectionTimeout="20000" disableUploadTimeout="true" />
<!-- Define an AJP 1.3 Connector on port 8009 -->
    <Connector port="9009"                                  端口：8009->9009
               enableLookups="false" redirectPort="8443" protocol="AJP/1.3" />
 
 
分别进入两个tomcat的bin目录，启动tomcat--./startup.sh





#启动jar包
java -jar -Xms512m -Xmx512m fl.open.provide-1.0.0-SNAPSHOT.jar &
#postman测试
http://114.116.4.178:9080/fsoa.usermanager.web/user/login?userInfo={ "code": "30001", "encryptPassWord": "123456", 	"userName": "zhangsan", 	"validate": "10787b0853addadf2d12b122bdd3f17535ce99b9db8f4bafb96e8dad9a6b58d2" }


