# hadoop cdh集群部署

## [准备工作](docs/prepare.md)
## [zookeeper部署](docs/zk/install.md)  
## [Hadoop部署](docs/hadoop/install.md)  

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
