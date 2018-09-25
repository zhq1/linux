#ssh免密登陆
ssh-copy-id -i ~/.ssh/id_rsa.pub webadm@192.168.1.69
#linux远程执行命令
ssh webadm@192.168.1.45 "cd /home/ ; ls"
#有或者
#!/bin/bash
ssh user@remoteNode > /dev/null 2>&1 << eeooff
cd /home
touch abcdefg.txt
exit
eeooff
echo done!