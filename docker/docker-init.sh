#!/usr/bin/env bash
## linux安装
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io
#启动docker并设置开机自启
systemctl start docker
sudo systemctl start docker
sudo systemctl enable docker

#添加docker组
sudo groupadd docker
#将当权用户添加到docker组
sudo gpasswd -a $USER docker
newgrp docker

#添加 镜像加速
sudo vim /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker

#登陆
docker login --> weisonwei/Hello@2019
docker pull portainer
http://localhost:9001/#/containers

#Ensure that you have started the Portainer container with the following Docker flag:
#-v "/var/run/docker.sock:/var/run/docker.sock" (Linux).
#-v \\.\pipe\docker_engine:\\.\pipe\docker_engine (Windows).
```

## docker compose
https://github.com/docker/compose/releases
# --
sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-Linux-x86_64 \
-o /usr/local/bin/docker-compose \

sudo chmod +x /usr/local/bin/docker-compose
sudo chmod a+rx /usr/local/bin/docker-compose
# --
