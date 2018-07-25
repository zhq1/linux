#!/usr/bin/python
#auther: Jacky
#date: 2016-08-01
#filename: ping_ip.py


import os,sys
import subprocess,cmd

def subping():
    f = open("ip_list.txt","r")

    lines = f.readlines()
    for line in lines:
        line=line.strip('\n')
        ret = subprocess.call("ping -c 2 -w 5 %s" % line,shell=True,stdout=subprocess.PIPE)
        if ret == 0:
            str = '%s is alive' % line
            print str
        elif ret == 1:
            str = '%s is not alive' % line
            print str
    f.close()


subping()