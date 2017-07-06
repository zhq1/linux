#!/bin/bash
to=$1
subject=$2
body=$3
/usr/local/bin/sendEmail  -f 15235751241@163.com -t "$to" -s smtp.163.com -u "$subject" -o message-content-type=html -o message-charset=utf8 -xu 15235751241@163.com -xp zhang810963 -m "$body"

