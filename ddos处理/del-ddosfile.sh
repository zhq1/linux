#!/bin/bash
cd /
file=`ls -l | grep ^- | awk '{print $9}'`
#echo $file
chattr -i $file
rm -f $file
