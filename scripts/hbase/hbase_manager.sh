#!/bin/bash

MASTER_SCRIPT="service hbase-master"
REGIONSERVER_SCRIPT="service hbase-regionserver"
THRIFT_SCRIPT="service hbase-thrift"

BASE_DIR=$(cd `dirname $0`; pwd)
REGIONSERVER_ADDRESS=$BASE_DIR/regionservers
MASTER_ADDRESS=$BASE_DIR/masters
THRIFT_ADDRESS=$BASE_DIR/thrift

HBASE_CONF=/etc/hbase/conf
TMP_CONF=$BASE_DIR/conf

MASTER=$(sed -n '1p' $MASTER_ADDRESS)
MASTER_BK=$(sed -n '2p' $MASTER_ADDRESS)

exec_start() {
	echo "[start master]..."
	pssh -H $MASTER -i "sudo $MASTER_SCRIPT start"
	echo "[start thrift]..."
	pssh -h $THRIFT_ADDRESS -i "sudo $THRIFT_SCRIPT start"
	echo "[start backup master]..."
	sleep 1
	pssh -H $MASTER_BK -i "sudo $MASTER_SCRIPT start"
	echo "[start regionserver]..."
	sleep 1
	pssh -i -h $REGIONSERVER_ADDRESS "sudo $REGIONSERVER_SCRIPT start"
}

exec_stop() {
	echo "[stop regionserver]..."
	pssh -i -h $REGIONSERVER_ADDRESS "sudo $REGIONSERVER_SCRIPT stop"
	sleep 1
	echo "[stop master]..."
	pssh -i -h $MASTER_ADDRESS "sudo $MASTER_SCRIPT stop"
	echo "[stop thrift]..."
	pssh -h $THRIFT_ADDRESS -i "sudo $THRIFT_SCRIPT stop"
}

exec_status() {
	echo "[master status]..."
	pssh -i -h $MASTER_ADDRESS "sudo $MASTER_SCRIPT status"
	echo "[thrift status]..."
	pssh -h $THRIFT_ADDRESS -i "sudo $THRIFT_SCRIPT status"
	echo "[regionserver status]..."
	pssh -i -h $REGIONSERVER_ADDRESS "sudo $REGIONSERVER_SCRIPT status"
}

sync() {
	echo "[sync configuration]..."
	prsync -h $REGIONSERVER_ADDRESS -r $TMP_CONF $BASE_DIR
	prsync -h $MASTER_ADDRESS -r $TMP_CONF $BASE_DIR
	prsync -h $THRIFT_ADDRESS -r $TMP_CONF $BASE_DIR
	echo "[replace configuration]..."
	pssh -h $REGIONSERVER_ADDRESS -i "sudo cp -rf $TMP_CONF/* $HBASE_CONF"
	pssh -h $MASTER_ADDRESS -i "sudo cp -rf $TMP_CONF/* $HBASE_CONF"
	pssh -h $THRIFT_ADDRESS -i "sudo cp -rf $TMP_CONF/* $HBASE_CONF"
}


case "$1" in
   'start')
     exec_start
     ;;
   'stop')
     exec_stop
     ;;
   'restart')
     exec_stop
     exec_start
     ;;
   'status')
     exec_status
     ;;
   'sync')
     sync
     ;;
   *)
     echo "Usage: $0 {start|stop|restart|status|sync}"
     exit 1
esac

exit 0


