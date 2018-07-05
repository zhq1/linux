#docker 运行jenkins
docker pull jenkinsci/blueocean
docker volume create jenkins-data
docker run -u root  -d -p 8090:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkinsci/blueocean
#密码保存数据卷下
/var/lib/docker/volumes/jenkins-data/_data/secrets
