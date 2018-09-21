#history_path
export HISTSIZE=65535
export HISTFILESIZE=65535
USER_IP=`who -u am i 2>/dev/null| awk '{print $NF}'|sed -e 's/[()]//g'`  
export HISTTIMEFORMAT="[%F %T][`whoami`][${USER_IP}] "
