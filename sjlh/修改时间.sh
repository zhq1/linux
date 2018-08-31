#!/bin/sh
#Shell菜单演示
function menu ()
{
 cat << EOF
----------------------------------------
|***************菜单主页***************|
----------------------------------------
`echo -e "\033[35m 1)修改时间\033[0m"`
`echo -e "\033[35m 2)同步时间\033[0m"`
`echo -e "\033[35m 3)退出菜单\033[0m"`
EOF
read -p "请输入要修改的时间：" num1
case $num1 in
 1)
  echo "修改时间"
  date_modify
  ;;
 2)
  echo "同步时间"
  ntp_date
  ;;
 3)
  exit 0
esac
}

#自定义时间
function date_modify ()
{
 echo "输入时间格式如:09/30/2018 17:20"
 read  in_time
 env_time=$in_time
 date -s "${env_time}" && hwclock --systohc
}

#同步当前时间
function ntp_date ()
{
 ntpdate time.sicdt.com && hwclock --systohc
}
menu