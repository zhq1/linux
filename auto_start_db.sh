#!/bin/bash

#Mysql的状态

mysql_pid=`pgrep ^mysqld$`
Mysql_status=`service mysqld status`

Mysql_Data="/Sicdtwork/data_mysql/3306"
Locks="/var/lock/subsys/mysql"
hostname=`hostname`

MySQL_start(){
        if [ -e ${hostname}.pid ];then
                rm -f $Mysql_Data/${hostname}.pid
        fi

        if [ -e $Locks ];then
                rm -f $Locks
        fi

        /etc/init.d/mysqld start >>/dev/null

}


#Mongodb的状态

mongodb_pid=`pgrep ^mongod$`
Mongodb_dir="/data/mongodb/mongodb-3.2.10"
pid_file=`cat ${Mongodb_dir}/mongodb.conf| grep pidFilePath|cut -d : -f2`
Mongodb_status=`service mongod status`


Mongodb_start()
{
	if [ -e ${pid_file} ];then
                rm -f ${pid_file}
        fi	
	if [ -f /var/lock/subsys/mongod ];then
		rm -f /var/lock/subsys/mongod
	fi
	
	/etc/init.d/mongod start >>/dev/null

}

if [ ! $mysql_pid ];then

	echo -e "Mysql not startup.\\n"
	echo -e "Start MySQL......\\n" 
	
	MySQL_start
else
	
	echo -e "Mysql already start.\\n	$Mysql_status"
fi

if [ ! $mongodb_pid ];then

	echo -e "Mongodb not startup.\\n"
	echo -e "Start Mongodb......\\n"

	Mongodb_start
else
	echo -e "Mongodb already start.\\n  $Mongodb_status"
fi



