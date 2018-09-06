1、在tomcat——>conf——>servler.xml文件中定义：
<Context path="/test" docBase="/test"  
　　defaultSessionTimeOut="3600" isWARExpanded="true"  
　　isWARValidated="false" isInvokerEnabled="true"  
　　isWorkDirPersistent="false"/>

2、在web.xml中定义：这个针对具体项目：
<session-config>  
<session-timeout>20</session-timeout>  
</session-config>

3、在程序中定义：这个就针对具体页面了：
session.setMaxInactiveInterval（30*60）；

4、配置tomcat的session持久化：
<Manager
className="org.apache.catalina.session.PersistentManager"
saveOnRestart="true"
maxActiveSession="-1"
minIdleSwap="0"
maxIdleSwap="30"
maxIdleBackup="0"
> 
<Store
className="org.apache.catalina.session.FileStore"
checkInterval=”60”
directory="../session"/>
</Manager>
或
<Store 
calssName="org.apache.catalina.JDBCStore"
driverName="com.mysql.jdbc.Driver" 
connectionURL="jdbc:mysql://localhost/tomsessionDB?user=root&password=" 
sessionTable="tomcat_session" 
sessionIdCol="session_id" 
sessionDataCol="session_data" 
sessionValidCol="session_valid" 
sessionMaxInactiveCol="max_inactive" 
sessionLastAccessedCol="last_access"
sessionAppCol="app_name" 
checkInterval="60" 
debug="99" />
maxActiveSessions－可处于活动状态的session数，default -1 不限制

checkInterval － 检查session是否过期的时间间隔，default 60s

saveOnRestart－服务器关闭时，是否将所有的session保存到文件中；
minIdleSwap/maxIdleSwap－session处于不活动状态最短/长时间(s)，sesson对象转移到File Store中；(－1表示没有限制)
maxIdleBackup－超过这一时间，将session备份。(－1表示没有限制)

directory－文件存储位置work\Catalina\host name\web app\session\文件名.session