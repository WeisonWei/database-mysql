# db-mysql
## linux安装docker
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
```    
