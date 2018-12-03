### 依赖
1、hbase 依赖hadoop，需要预先建好hadoop的根目录，例如hdfs://ns/hbase。
2、安装好1.8版本的java
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
