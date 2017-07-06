#!/bin/bash
#
# Filename:    sendSMS.sh
# Revision:    1.0
# Date:        2016/11/23
# Author:      
# Email:       sdata@foxmail.com
# Description: zabbix短信告警脚本

# 脚本的日志文件
LOGFILE="/tmp/s1.log"
>"$LOGFILE"
exec 1>"$LOGFILE"
exec 2>&1

# Uid 网站用户名
# Key 接口秘钥
Uid="guoxinjianing"
Key="1A06091BA5506771B5D1063F2C9B46FF"

MOBILE_NUMBER=$1    # 手机号码
MESSAGE_NAME=【包商平台】$3      # 短信内容
MESSAGE_UTF8=`iconv -t GB2312 -f UTF-8 << EOF
$MESSAGE_NAME
EOF`
XXD="/usr/bin/xxd"
CURL="/usr/bin/curl"
TIMEOUT=5

# 短信内容要经过URL编码处理，除了下面这种方法，也可以用curl的--data-urlencode选项实现。
MESSAGE_ENCODE=$(echo "$MESSAGE_UTF8" | ${XXD} -ps | sed 's/\(..\)/%\1/g' | tr -d '\n')
# SMS API
#URL="http://123.45.67.89:9876/QxtSms/QxtFirewall?OperID=${Uid}&OperPass=${Key}&SendTime=&ValidTime=&AppendID=0000&DesMobile=${MOBILE_NUMBER}&Content=${MESSAGE_ENCODE}&ContentType=8"
URL="http://api.106txt.com/smsGBK.aspx?action=Send&username=${Uid}&password=${Key}&gwid=53&mobile=${MOBILE_NUMBER}&message=${MESSAGE_ENCODE}"

# Send it
set -x
${CURL} -s --connect-timeout ${TIMEOUT} "${URL}"

