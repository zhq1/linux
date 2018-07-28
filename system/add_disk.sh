parted /dev/sdb
fdisk -l
mkfs.xfs /dev/sdb
mkfs.xfs -f /dev/sdb
fdisk -l
vim /etc/fstab
vi /etc/fstab
mkdir /data
mount -a
vi /etc/fstab
mount -a
df -h
cd /data/
ll
mkdir dd
touch 123
vim 123
vi 123
smartctl -a /dev/sdb
hdparm
yum install hdparm
hdparm -Tt /dev/sdb
hdparm -Tt /dev/sda1
iostat -d -k -x 1 10
