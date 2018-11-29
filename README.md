# hadoop cdh集群部署

## [准备工作](docs/prepare.md)
## Zookeeper部署
所有操作都在root权限下执行  
在big-data-1上:  
cd cluster  
sh install-zk.sh  
在big-data-1至big-data-3分别执行  
echo 1 >  /data/zookeeper/myid    
echo 2 >  /data/zookeeper/myid    
echo 3 >  /data/zookeeper/myid    
在big-data-1  
pssh -i -h zk.host sudo /etc/init.d/zookeeper-server init  
pssh -i -h zk.host sudo /etc/init.d/zookeeper-server start  
卸载:  
pssh -i -h zk.host sudo yum remove zookeeper-server


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
### install
sudo yum install hive hive-metastore hive-server2 zookeeper hadoop-lzo -y;  
sudo mkdir -p /opt/log/hive/;  
sudo chmod -R 777 /opt/log/hive/;  
sudo mkdir -p /opt/log/hadoop/;  
sudo chmod -R 777 /opt/log/hadoop/;  
sudo mkdir -p /tmp/hive/;  
sudo chown hive: /tmp/hive/;  
sudo touch /var/log/hive/hive_audit.log;  
sudo chmod 777 /var/log//hive/hive_audit.log  

### conf setting 
/etc/hive/conf/hive-site.xml

### start
sudo /etc/init.d/hive-metastore start  
sudo /etc/init.d/hive-server2 start

### test
select count(1);


## Hbase部署
### 依赖
1、hbase 依赖hadoop，需要预先建好hadoop的根目录，例如hdfs://ns/hbase。
2、安装好1.7版本以上的java
3、安装好Zookeeper

### 准备
1、将项目的./conf/hbase目录以/conf的形式复制入./script/hbase下
2、修改./script/hbase/masters为master节点
3、修改./script/hbase/regionservers为rs节点

### 安装
执行./script/hbase/install_hbase.sh install

### 同步配置
0、进入./script/hbase/conf文件夹
1、修改配置文件hbase-site.xml中的hbase.zookeeper.quorum项为zk地址
2、修改配置文件hbase-site.xml中的hbase.rootdir项为实际hdfs地址
3、依据服务器的实际情况修改配置文件hbase-env.sh中的jvm配置。
4、执行./script/hbase/hbase_manager.sh sync

### 启动
执行./script/hbase/hbase_manager.sh start

### 验证服务状态
1、./script/hbase/hbase_manager.sh status
2、访问 http://[master_host_ip]:60010/master-status
3、访问hbase shell -->list


## [Spark部署](docs/spark/install.md)



