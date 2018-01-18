#!/bin/bash
#!/bin/bash
max=300    #我们设定的最大值，当访问量大于这个值得时候，封锁
logdir=/var/log/haproxy/haproxy.log  #haproxy访问日志文件路径
port=80
drop_ip=""
cat $logdir | awk -F ":" '{print $4}' | grep -Ev "10.10.66.*|124.204.49.90"| sort | uniq -c | sort -rn > /var/log/haproxy/ip.txt
#循环遍历日志文件取出访问量大于500的ip
for drop_ip  in $(cat /var/log/haproxy/ip.txt | awk '{if ($1>300) print $2}')
do
  grep  -q  "${drop_ip}" /var/log/haproxy/ip.txt && eg=1 || eg=0;
  if (( ${eg}==0 ));then
     iptables -I INPUT -p tcp --dport ${port} -s ${drop_ip} -j DROP
     echo ">>>>> `date '+%Y-%m-%d %H%M%S'` - 发现攻击源地址 ->  ${drop_ip} " >> /var/log/haproxy/haproxy_deny.log  #记录log
  fi
done
