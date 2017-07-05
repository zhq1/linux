r=$(dirname `readlink -f "$0"`)
cd $Dir
export JRE_HOME=/usr/local/java/jre
export TZ='Asia/Shanghai'
export LANG=zh_CN.UTF-8
sh /usr/local/app/extract/go.sh
sh /usr/local/app/inceptor/go.sh
sh /usr/local/app/save/go.sh
sh /usr/local/app/web/go.sh
sh /usr/local/app/job/go.sh

