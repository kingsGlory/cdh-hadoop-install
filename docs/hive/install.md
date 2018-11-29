## Hive服务包括HiveServer2和Metastore两部分，HiveServer2和Metastore服务的部署步骤一致，目前测试环境是HiveServer2和Metastore服务是一一对应的
## 准备工作
1. 准备一台部署的主控机，主控机可以ssh无密码登录到要部署hive服务的机器。同时，主控机可以使用pssh、pscp、prsync等命令
2. 要部署hive服务的机器提前安装好hadoop客户端，同时准备好要连接的MySQL服务器

## 部署步骤
1. 登录到主控机，`cd cdh-hadoop-install`
2. 修改metastore_hosts和server2_hosts文件，分别写入安装metastore和hiveserver2的ip地址
3. 安装metastore和hiveserver2：`./scripts/hive/hive-manager.sh install server2_hosts`(目前server2_hosts和metastore_hosts内容是相同的)
4. 同步配置文件：`./scripts/hive/hive-manager.sh sync`
5. 启动metastore和hiveserver2服务：`./scripts/hive/hive-manager.sh start`

## 服务管理(首先登录主控机步骤同上)
1. 停止服务：`./scripts/hive/hive-manager.sh stop`
2. 重启服务：`./scripts/hive/hive-manager.sh restart`
3. 修改配置文件后同步：`./scripts/hive/hive-manager.sh sync`(修改配置文件后，一般需要重启服务)

## 服务验证
   登录任意hive服务所在机器，`beeline -n tuhu -u "jdbc:hive2://big-data-5:10000/default"`，执行`show databases;show tables;select count(1);`等命令
