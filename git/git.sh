#!/usr/bin/env bash
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
