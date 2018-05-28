mkfs.ext3 /dev/sdb
mkdir /data
vi /etc/fstab
/dev/sdb        /data   ext3    defaults        0       0
#查询UUID命令
blkid
yum install -y mod_dav_svn subversion
