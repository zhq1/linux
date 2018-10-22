ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub root@140.143.237.96
ssh-copy-id -i ~/.ssh/id_rsa.pub webadm@192.168.1.69
ansible business_node -m ping --private-key=/root/KeyPair-Online.pem
ansible business_node -m copy  -a  "src=/home/paas/docker_update/  dest=/home/paas/docker_update/ mode=700 owner=root group=root" --private-key=/root/KeyPair-Online.pem