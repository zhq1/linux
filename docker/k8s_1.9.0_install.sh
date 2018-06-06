sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
wget https://raw.githubusercontent.com/21ki/vos/master/aliyun-sysctl.conf 
mv aliyun-sysctl.conf /etc/sysctl.conf
hostnamectl set-hostname master

systemctl stop firewalld  && systemctl disable firewalld  

yum install -y iptables-services 
systemctl enable iptables  && systemctl restart iptables


echo "
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
" >> /etc/sysctl.conf
#导入模块
modprobe br_netfilter
sysctl -p

#关闭swap
vi /etc/fstab

cd k8s_images
yum localinstall -y docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch.rpm 
yum localinstall -y docker-ce-17.03.2.ce-1.el7.centos.x86_64.rpm
systemctl start docker && systemctl enable docker
docker info |grep Cg

docker load < /root/k8s_images/docker_images/etcd-amd64_v3.1.10.tar
docker load </root/k8s_images/docker_images/flannel\:v0.9.1-amd64.tar
docker load </root/k8s_images/docker_images/k8s-dns-dnsmasq-nanny-amd64_v1.14.7.tar
docker load </root/k8s_images/docker_images/k8s-dns-kube-dns-amd64_1.14.7.tar
docker load </root/k8s_images/docker_images/k8s-dns-sidecar-amd64_1.14.7.tar
docker load </root/k8s_images/docker_images/kube-apiserver-amd64_v1.9.0.tar
docker load </root/k8s_images/docker_images/kube-controller-manager-amd64_v1.9.0.tar
docker load </root/k8s_images/docker_images/kube-scheduler-amd64_v1.9.0.tar
docker load < /root/k8s_images/docker_images/kube-proxy-amd64_v1.9.0.tar
docker load </root/k8s_images/docker_images/pause-amd64_3.0.tar
docker load < /root/k8s_images/kubernetes-dashboard_v1.8.1.tar


rpm -ivh socat-1.7.3.2-2.el7.x86_64.rpm
rpm -ivh kubernetes-cni-0.6.0-0.x86_64.rpm  kubelet-1.9.9-9.x86_64.rpm  kubectl-1.9.0-0.x86_64.rpm
rpm -ivh kubectl-1.9.0-0.x86_64.rpm
rpm -ivh kubeadm-1.9.0-0.x86_64.rpm

vi /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=cgroupfs"

#重置环境
#kubeadm reset

#将kubeadm join xxx保存下来，等下node节点需要使用
#如果忘记了，可以在master上通过kubeadmin token list得到
#默认token 24小时就会过期，后续的机器要加入集群需要重新生成token
#kubeadm token create
systemctl daemon-reload

systemctl enable kubelet && sudo systemctl start kubelet

kubeadm init --kubernetes-version=v1.9.0 --pod-network-cidr=10.244.0.0/16

vi /etc/profile
export KUBECONFIG=/etc/kubernetes/admin.conf


source /etc/profile
kubectl get pods --all-namespaces
kubectl get pods --all-namespaces -o wide
#以yawl格式输出pod的详细信息
kubectl get po nginx-8586cf59-7sqjh -o yaml
#以jison格式输出pod的详细信息
kubectl get po nginx-8586cf59-7sqjh -o json
#定义直接获取指定内容的值
kubectl get po nginx-8586cf59-7sqjh -o=custom-columns=LABELS:.metadata.labels.app
#查看pod日志
kubectl logs  httpd-8576c89d7-qzsln
#查看pod没有run的原因和get的差别再次
kubectl describe pods nginx-8586cf59-7sqjh
#修改pod内存cpu
kubectl edit deploy bs-fl-ec-active-provide
#查看deployment启动日志
kubectl describe deployment bs-fl-ec-personal-provide


#安装calico网络
kubectl apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/rbac.yaml
curl https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/calico.yaml -o calico.yaml
kubectl apply -f calico.yaml



#安装flannel网络
wget https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml
kubectl create -f kube-flannel.yml
kubectl get pods --all-namespaces -o wide


#k8s起不来的问题 过滤出问题的pods
kubectl get pods -n kube-system | grep -v Running
#查看calico-node-8ncjv的日志
kubectl describe pod calico-node-8ncjv -n kube-system
kubectl delete pod calico-node-8ncjv -n kube-system
