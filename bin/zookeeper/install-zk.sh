pssh -i -h zk.host sudo mkdir -p /data/zookeeper
pssh -i -h zk.host sudo mkdir -p /data1/zookeeper
pssh -i -h zk.host sudo yum install zookeeper-server -y
pssh -i -h zk.host sudo chown zookeeper:zookeeper /data/zookeeper
pssh -i -h zk.host sudo chown zookeeper:zookeeper /data1/zookeeper
pscp.pssh -h zk.host  zk/conf/zoo.cfg /tmp/
pscp.pssh -h zk.host  zk/conf/java.env /tmp/
pssh -h zk.host mv /tmp/zoo.cfg /usr/lib/zookeeper/conf/
pssh -h zk.host mv /tmp/java.env /usr/lib/zookeeper/conf/
pssh -i -h zk.host sudo chown zookeeper:zookeeper /usr/lib/zookeeper/conf/zoo.cfg
pssh -i -h zk.host sudo chown zookeeper:zookeeper /usr/lib/zookeeper/conf/java.env
