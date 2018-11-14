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
### 建目录
#### common  
mkdir -p /opt/log/hadoop  
chown :hadoop /opt/log/hadoop  
chmod 755  /opt/log/hadoop  
mkdir -p /opt/log/mapred  
chown mapred:hadoop /opt/log/mapred  
mkdir -p /opt/log/yarn  
chown yarn:hadoop /opt/log/yarn  
mkdir -p /opt/log/hdfs  
chown hdfs:hadoop /opt/log/hdfs  
chmod 755 /opt/log/hdfs  

#### nn jn  
mkdir -p /opt/data/hdfs/namenode  
chown hdfs:hadoop /opt/data/hdfs/namenode  
chmod 755 /opt/data/hdfs/namenode  
mkdir -p /opt/data/hdfs/journalnode  
chown hdfs:hadoop /opt/data/hdfs/journalnode  
chmod 755 /opt/data/hdfs/journalnode  

##### dn nm  
mkdir  /{{item}}/hdfs  
chown hdfs:hadoop /{{data}}/hdfs  
chmod 700  /{{data}}/hdfs  
mkdir /{{item}}/yarn/local  
mkdir /{{item}}/yarn/logs  
mkdir /{{item}}/yarn  
chown yarn:hadoop /{{item}}/yarn  
chmod 755 /{{item}}/yarn  

### jn
安装：  
yum install hadoop-hdfs-journalnode -y  
启动:  
/etc/init.d/hadoop-hdfs-journalnode start  

### nn 
安装:  
yum install hadoop-hdfs-namenode -y  
启动:  
/etc/init.d/hadoop-hdfs-namenode start  
hdfs hdfs namenode -format  
bin/hdfs namenode  -bootstrapStandby  

### zkfc  
安装:  
yum install hadoop-hdfs-zkfc -y  
启动:  
/etc/init.d/hadoop-hdfs-zkfc start  

### rm  
安装:  
yum install hadoop-yarn-resourcemanager -y  
启动:  
/etc/init.d/hadoop-yarn-nodemanager start  

### dn  
安装： 
yum install hadoop-hdfs-datanode -y  
启动： 
/etc/init.d/hadoop-hdfs-datanode start  

### nm 
安装:   
yum install hadoop-yarn-nodemanager -y  
启动:  
/etc/init.d/hadoop-yarn-nodemanager start  


## Hive部署
sudo yum install hive hive-metastore hive-server2 zookeeper hadoop-lzo -y
sudo mkdir -p /opt/log/hive/;
sudo chmod -R 777 /opt/log/hive/;
sudo mkdir -p /opt/log/hadoop/;
sudo chmod -R 777 /opt/log/hadoop/;
sudo mkdir -p /tmp/hive/;
sudo chown hive: /tmp/hive/;
sudo touch /var/log/hive/hive_audit.log;
sudo chmod 777 /var/log//hive/hive_audit.log

## Hbase部署

## Spark部署



