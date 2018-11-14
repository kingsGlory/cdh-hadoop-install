# hadoop cdh集群部署

## [准备工作](docs/prepare.md)
## Zookeeper部署
所有操作都在root权限下执行
yum install zookeeper-server  
dataDir=/data/zookeeper  
dataLogDir=/data1/zookeeper  
log4jDir=/opt/log/zookeeper  
mkdir /data/zookeeper  
mkdir /data1/zookeeper  
mmkdir -p /opt/log/zookeeper  
chown  zookeeper:zookeeper /data/zookeeper 
chown  zookeeper:zookeeper /data1/zookeeper  
chown  zookeeper:zookeeper /opt/log/zookeeper  
cp log4j.properties /etc/zookeeper/conf/log4j.properties  
cp zoo.cfg /etc/zookeeper/conf/zoo.cfg  
/etc/init.d/zookeeper-server start  

## Hadoop部署

## Hive部署

## Hbase部署

## Spark部署



