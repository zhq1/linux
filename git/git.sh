#!/usr/bin/env bash
yum install -y git
git init
git config --global user.name "fuhua_qa"
git config --global user.email "fuhua_qa@example.com"
git add .
git add xiaofan
git commit -m '201806131117'



git clone  root@192.168.3.177:/root/myki/.git
git pull  root@192.168.3.177:/root/myki/.git
