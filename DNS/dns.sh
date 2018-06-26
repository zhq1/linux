yum -y install bind
vim /etc/named.conf
options {
        listen-on port 53 { any; };
        allow-query     { any; };


vim /etc/named.rfc1912.zones
zone "1nth.com" IN {
        type master;
        file "1nth.com.zone";
        allow-update { none; };
};


named-checkconf
cd /var/named/
cp -f named.localhost 1nth.com.zone

vim 1nth.com.zone
$TTL 1D
@       IN SOA  @ rname.invalid. (
                                        0       ; serial
                                        1D      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
        NS      @
        A       127.0.0.1
        AAAA    ::1
dns     IN      A       192.168.2.1
time    IN      A       192.168.2.6



#查询dns命令如下
dig -t www.baidu.com @223.5.5.5
dig -t NS yum.1nth.com
dit -t A yum.1nth.com
dig -t A yum.1nth.com @114.114.114.114
dig -t A yum.1nth.com +trace
