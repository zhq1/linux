ping cms-cloudmonitor.aliyun.com
140.205.172.20  cms-cloudmonitor.aliyun.com
sudo bash -c 'CMS_AGENT_ACCESSKEY=NXieTjeTSgM CMS_AGENT_SECRETKEY=dXkQx0O3R-Jdch6DK2J5qA VERSION=1.2.11 bash -c "$(curl -L http://cms-download.aliyun.com/release/install_linux.sh)"'
#安装缺少的组件
yum search iproute2