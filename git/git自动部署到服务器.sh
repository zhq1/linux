#参考https://www.jianshu.com/p/5c7ce1b02100



#服务器上操作命令如下
mkdir -p /opt/git/.git
cd git
chmod 777 /opt/git/
cd /opt/git/.git/
git init --bare
vi config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true

[receive]
        denyCurrentBranch = ignore

useradd -s /bin/bash git
chown git:git -R /opt/git/.git

cd hooks/
vi post-receive
#!/bin/sh
#路径

PATH=$PATH:/usr/local/python27/bin
GIT_WORK_TREE=/opt/scrp git checkout -f
cd /opt/scrp && make html >/dev/null 2>&1


mkdir -p /opt/scrp
chmod +x post-receive
chown git:git -R /opt/scrp/


#客户端操作命令
mkdir git_test
cd git_test/
git init
git config user.email"sjhl@git.com"
git config user.name  "Myki"
touch  1
git add .
git commit -m "1"
git remote add dev git@192.168.10.34:/opt/git/.git
git push dev master
