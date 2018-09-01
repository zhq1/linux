if [ -z "`mii-tool eth0 | grep ok`"]
then
    echo "offline"
else
    echo "online"
fi



#方法2
ethtool eth1 |grep Link


#方法3
cat /proc/net/dev