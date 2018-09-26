
#LInux遇到 "init: /dev/initctl: no such file"问题，执行如下命令：
mkfifo /dev/initctl
reboot -f

#重置密码
rm -rf /tik/rw/store/user.dat