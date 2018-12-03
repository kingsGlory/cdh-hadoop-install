#!/bin/bash

PWD_DIR=$(cd `dirname $0`;pwd)
BASE_DIR=$PWD_DIR/../..

LOCAL_CONF=$BASE_DIR/conf/hive/conf
LOCAL_LIB=$LOCAL_CONF/lib

HIVE_LIB=/usr/lib/hive/lib
HIVE_CONF=/etc/hive/conf

METASTORE_ADDR=$LOCAL_CONF/metastore_hosts
SERVER2_ADDR=$LOCAL_CONF/server2_hosts

METASTORE_SCRIPT="sudo /etc/init.d/hive-metastore"
SERVER2_SCRIPT="sudo /etc/init.d/hive-server2"

exec_install() {
  pssh -h $1 -i -t 600 "sudo yum install hive hive-metastore hive-server2 -y;sudo mkdir -p /opt/log/hive/;sudo chmod -R 777 /opt/log/hive/;sudo mkdir -p /opt/log/hadoop/;sudo chmod -R 777 /opt/log/hadoop/;sudo mkdir -p /tmp/hive/;sudo chown hive: /tmp/hive/;mkdir -p $LOCAL_LIB;sudo touch /var/log/hive/hive_audit.log;sudo chmod 777 /var/log/hive/hive_audit.log;"
  pscp -h $1 -r $LOCAL_LIB/* $LOCAL_LIB
  pssh -h $1 -i -t 600 "sudo cp -rf $LOCAL_LIB/* $HIVE_LIB"
}

exec_sync() {
    echo "[sync local:$LOCAL_CONF to remote]"
    prsync -h $SERVER2_ADDR -r $LOCAL_CONF $BASE_DIR
    echo "[replacing remote:$LOCAL_CONF to $HIVE_CONF]"
    pssh -h $SERVER2_ADDR -i "sudo cp -rf $LOCAL_CONF/* $HIVE_CONF/"
}

exec_start() {
    echo "[start hivemetastore]..."
    pssh -h $METASTORE_ADDR -i "$METASTORE_SCRIPT start"
    sleep 5
    echo "[start hiveserver2]..."
    pssh -h $SERVER2_ADDR -i "$SERVER2_SCRIPT start"
}

exec_stop() {
    echo "[stop hivemetastore]..."
    pssh -h $METASTORE_ADDR -i "$METASTORE_SCRIPT stop"
    echo "[stop hiveserver2]..."
    pssh -h $SERVER2_ADDR -i "$SERVER2_SCRIPT stop"
}

exec_restart() {
    echo "[restart hivemetastore]..."
    pssh -h $METASTORE_ADDR -i "$METASTORE_SCRIPT restart"
    sleep 5
    echo "[restart hiveserver2]..."
    pssh -h $SERVER2_ADDR -i "$SERVER2_SCRIPT restart"
}

case $1 in
    'start')
    exec_start
    ;;
    'stop')
    exec_stop
    ;;
    'sync')
    exec_sync
    ;;
    'restart')
    exec_restart
    ;;
    'install')
    exec_install $2
    ;;
esac

exit 0
