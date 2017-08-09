#!/bin/bash
top -b1 -n1 | sed '1,5d' | awk '{if($9>=20.00)print}' | awk '{print $1}' | xargs kill -9
干掉占用大于20%cpu的进程