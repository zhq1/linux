hostnamectl set-hostname  test  #修改主机名
nohup python -m SimpleHTTPServer 8001 &   #启动一个http
#把文件夹1并且附带文件夹1拷贝到2（1和2都是文件夹）
cp -dprf 1 2
#把文件3拷贝到2下面
cp -dprf 3 2
#把1文件夹下面的文件不附带文件夹1拷贝到2
cp -dprf 1/* 2/
cp -dprf 1/ 2/

#执行一次的命令
at 14:25 08/31/2018
at> sed -i '267s/#//' nginx.conf
Ctrl+D
替换267行的#为空