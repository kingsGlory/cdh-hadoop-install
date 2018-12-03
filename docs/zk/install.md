## 准备
1. 将zk的主机名放入主控机操作目录的zk.host， 所有操作都在root权限下执行。  

2. 在主控机的用户目录下，建立下面目录结构，并放入对应的配置文件。  

   ![dir](../../img/hadoop/init-dir.png)
## 部署
在主控机上执行:  
1. 安装: pssh -i -h zk.host sudo yum install zookeeper-server -y  
2. 建立目录:  
   pssh -i -h zk.host sudo mkdir -p /data/zookeeper  
   pssh -i -h zk.host sudo mkdir -p /data1/zookeeper  
   pssh -i -h zk.host sudo chown zookeeper:zookeeper /data/zookeeper  
   pssh -i -h zk.host sudo chown zookeeper:zookeeper /data1/zookeeper   
3. 配置文件:  
   pscp.pssh -h zk.host  zk/conf/zoo.cfg /tmp/  
   pscp.pssh -h zk.host zk/conf/java.env /tmp/  
   pssh -h zk.host mv /tmp/zoo.cfg /usr/lib/zookeeper/conf/  
   pssh -h zk.host mv /tmp/java.env /usr/lib/zookeeper/conf/  
   pssh -i -h zk.host sudo chown zookeeper:zookeeper /usr/lib/zookeeper/conf/zoo.cfg  
   pssh -i -h zk.host sudo chown zookeeper:zookeeper /usr/lib/zookeeper/conf/java.env  
4. 在每台zk机器上执行：  
   1号机：echo 1 > /data/zookeeper/myid  
   2号机：echo 2 > /data/zookeeper/myid  
   3号机：echo 3 > /data/zookeeper/myid  
## 初始化及启动  
1. 在主控机上执行:  
   pssh -i -h zk.host sudo /etc/init.d/zookeeper-server init  
   pssh -i -h zk.host sudo /etc/init.d/zookeeper-server start  
## 卸载  
1. pssh -i -h zk.host sudo yum remove zookeeper-server   

## 验证
1. 登录zk集群: big-data-1: zookeeper-client 查看是否正常。
