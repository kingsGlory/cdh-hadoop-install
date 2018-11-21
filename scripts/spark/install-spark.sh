#! /bin/bash
set -ex
# 首先确保当前目录在 cdh-hadoop-install 目录中

spark_version=spark-2.4.0-bin-hadoop2.6

# 1. 预先部署好了hadoop
# 2. 磁盘下有安装java
# 3. 需要预先将spark相应安装包放到ftp服务器中
ftp_username=ftp_username
ftp_password=ftp_password


echo "Downloading..."
if [ ! -f $spark_version.tgz ]
then
	wget ftp://ftp-adress/spark/$spark_version.tgz --ftp-user=$ftp_username --ftp-password=$ftp_password
fi

echo "Download finished, extracting..."
tar -zvxf $spark_version.tgz -C /usr/local/

ln -s /usr/local/spark /usr/local/$spark_version

echo "Installed finished, configurating..."
# 将配置文件拷贝到spark对应目录下
cp conf/spark/conf/* /usr/local/$spark_version/conf

echo 'export SPARK_HOME=/usr/local/spark'  >> /etc/profile
echo 'export PATH=$SPARK_HOME/bin:$PATH'  >> /etc/profile

echo "验证环境变量"
tail  /etc/profile

echo "env 配置"
tail /etc/spark/conf/spark-env.sh  -n 4
