#!/usr/bin/env bash
 cat /var/svn/feifei/conf/authz
[/]
feifei=rw


 cat /var/svn/feifei/conf/passwd 
[users]
# harry = harryssecret
# sally = sallyssecret
feifei = woaiwojia

[general]
anon-access = read
anon-access = none
auth-access = write
password-db = passwd
authz-db = authz
realm = /var/svn/feifei
[sasl]
