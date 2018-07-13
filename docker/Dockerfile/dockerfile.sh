tar -zxvf jdk-8u121-linux-x64.tar.gz
tar -zxvf jdk-8u121-linux-x64.tar.gz
docker build -t cheche/tomcat .
docker run -tid a6ebba2ec06c bash
docker exec -it 64572a15cebc bash
docker stop 64572a15cebc87419
docker commit 64572a15cebc87419 cheche/tomcat:2018-07-13-14-56


docker commit -a "runoob.com" -m "my apache" a404c6c174a2  mymysql:v1
docker images mymysql:v1
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
mymysql             v1                  37af1236adef        15 seconds ago      329 MB