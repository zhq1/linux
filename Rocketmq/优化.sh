Rocketmq配置文件详解：

#所属集群名字  
brokerClusterName=DefaultCluster
#broker名字,注意此处不同的配置文件填写的不一样
brokerName=broker-a
#0 表示 Master,>0 表示 Slave
brokerId=0
#nameServer地址,分号分割
namesrvAddr=192.168.1.101:9876;192.168.1.102:9876

#关键
brokerIP1=192.168.1.101

#在发送消息时,自动创建服务器不存在的topic,默认创建的队列数
defaultTopicQueueNums=4
#是否允许 Broker 自动创建Topic,建议线下开启,线上关闭
autoCreateTopicEnable=true
#是否允许 Broker 自动创建订阅组,建议线下开启,线上关闭
autoCreateSubscriptionGroup=true
#Broker 对外服务的监听端口
listenPort=10911
#删除文件时间点,默认凌晨 4点
deleteWhen=04
#文件保留时间,默认 48 小时
fileReservedTime=48
#commitLog每个文件的大小默认1G
mapedFileSizeCommitLog=1073741824
#ConsumeQueue每个文件默认存30W条,根据业务情况调整
mapedFileSizeConsumeQueue=300000
#destroyMapedFileIntervalForcibly=120000
#redeleteHangedFileInterval=120000
#检测物理文件磁盘空间
diskMaxUsedSpaceRatio=88

#这里是我的 日志配置
#存储路径
storePathRootDir=/opt/rocketmq/store
#commitLog 存储路径
storePathCommitLog=/opt/rocketmq/store/commitlog
#消费队列存储路径存储路径
storePathConsumeQueue=/opt/rocketmq/store/consumequeue
#消息索引存储路径
storePathIndex=/opt/rocketmq/store/index
#checkpoint 文件存储路径
storeCheckpoint=/opt/rocketmq/store/checkpoint
#abort 文件存储路径
abortFile=/opt/rocketmq/store/abort


#限制的消息大小  
maxMessageSize=65536
#flushCommitLogLeastPages=4
#flushConsumeQueueLeastPages=2
#flushCommitLogThoroughInterval=10000
#flushConsumeQueueThoroughInterval=60000
#Broker 的角色
#- ASYNC_MASTER 异步复制Master
#- SYNC_MASTER 同步双写Master
#- SLAVE
brokerRole=ASYNC_MASTER
#刷盘方式
#- ASYNC_FLUSH 异步刷盘
#- SYNC_FLUSH 同步刷盘
flushDiskType=ASYNC_FLUSH

#checkTransactionMessageEnable=false
#发消息线程池数量
#sendMessageThreadPoolNums=128
#拉消息线程池数量
#pullMessageThreadPoolNums=128

Ailiyun优化脚本
#!/bin/sh
#
# Execute Only Once 只可执行一次
#
#用户名
USER=admin
#磁盘盘符
DISK=sda
##在grub.conf中添加参数 默认注释掉 需要使用请取消注释
#sed -i 's/kernel.*$/& elevator=deadline/' /etc/grub.conf

echo 'vm.overcommit_memory=1' >> /etc/sysctl.conf
echo 'vm.min_free_kbytes=5000000' >> /etc/sysctl.conf
echo 'vm.drop_caches=1' >> /etc/sysctl.conf
echo 'vm.zone_reclaim_mode=0' >> /etc/sysctl.conf
echo 'vm.max_map_count=655360' >> /etc/sysctl.conf
echo 'vm.dirty_background_ratio=50' >> /etc/sysctl.conf
echo 'vm.dirty_ratio=50' >> /etc/sysctl.conf
echo 'vm.page-cluster=3' >> /etc/sysctl.conf
echo 'vm.dirty_writeback_centisecs=360000' >> /etc/sysctl.conf
echo 'vm.swappiness=10' >> /etc/sysctl.conf
sysctl -p
echo "ulimit -n 655350" >> /etc/profile
echo "$USER hard nofile 655350" >> /etc/security/limits.conf
echo 'deadline' > /sys/block/$DISK/queue/scheduler
echo "---------------------------------------------------------------"
sysctl vm.overcommit_memory
sysctl vm.min_free_kbytes
sysctl vm.drop_caches
sysctl vm.zone_reclaim_mode
sysctl vm.max_map_count
sysctl vm.dirty_background_ratio
sysctl vm.dirty_ratio
sysctl vm.page-cluster
sysctl vm.dirty_writeback_centisecs
sysctl vm.swappiness
su - $USER -c 'ulimit -n'
cat /sys/block/$DISK/queue/scheduler

1.	overcommit_memory取值又三种分别为0， 1， 2
    overcommit_memory=0， 表示内核将检查是否有足够的可用内存供应用进程使用；如果有足够的可用内存，内存申请允许；否则，内存申请失败，并把错误返回给应用进程。
    overcommit_memory=1， 表示内核允许分配所有的物理内存，而不管当前的内存状态如何。
    overcommit_memory=2， 表示内核允许分配超过所有物理内存和交换空间总和的内存

