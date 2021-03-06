#!/usr/bin/env bash
#连接githup
ssh-keygen -t rsa -C "21kixc@gmail.com"
#oopy id_rsa.pub到githup上
#test
ssh -T git@github.com
#解决git每次输入密码的问题
git config --global credential.helper store
#把key传入git服务器
#ssh-copy-id -i ./id_rsa root@10.200.240.137
ssh-copy-id -i id_rsa root@10.200.240.137

yum install -y git
git init
git config --global user.name "fuhua_qa"
git config --global user.email "fuhua_qa@example.com"
git add .
git add xiaofan
git commit -m '201806131117'
cat .git/config 
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true

[receive]
        denyCurrentBranch = ignore
#获取缓存数据        
git reset --hard

#warning: LF will be replaced by CRLF in pom.xml.
The file will have its original line endings in your working directory.
#出现这个问题 解决办法
git config core.autocrlf false





git clone  root@192.168.3.177:/root/myki/.git
git pull  root@192.168.3.177:/root/myki/.git
git clone -b master root@49.4.64.59:/var/workspace/src/dev-tool/.git


#huawei拉取代码
git checkout .
git pull --rebase origin master
git log
git rebase --continue
git reset a0d0b32f37219f5e3dd690434584067cffcf90d7
git diff


#githup
#克隆远程仓库
git clone https://github.com/21ki/linux.git
git add .
git config --global user.email "hujialou@1nth.com"
git config --global user.name "Myki"
git commit -am "更新git上传githup"
git push origin master
