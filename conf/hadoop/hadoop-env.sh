# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Set Hadoop-specific environment variables here.
# Forcing YARN-based mapreduce implementaion. 
# Make sure to comment out if you want to go back to the default or
# if you want this to be tweakable on a per-user basis
#export HADOOP_MAPRED_HOME=/usr/lib/hadoop-mapreduce
#export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:/usr/local/ext-hadoop/*

#export HADOOP_ROOT_LOGGER=INFO,DRFA,CLHA

# The maximum amount of heap to use, in MB. Default is 1000.
#export HADOOP_HEAPSIZE=
#export HADOOP_NAMENODE_INIT_HEAPSIZE=""

# Extra Java runtime options.  Empty by default.
#export HADOOP_OPTS="-Djava.net.preferIPv4Stack=true $HADOOP_CLIENT_OPTS"
#export HADOOP_CLIENT_OPTS="-Xmx128m $HADOOP_CLIENT_OPTS"

# Hadoop log dir
export HADOOP_LOG_DIR=/opt/log/hadoop

## JMX settings
export JMX_OPTS=" -Dcom.sun.management.jmxremote.authenticate=false \
-Dcom.sun.management.jmxremote.ssl=false \
-Dcom.sun.management.jmxremote.port"

DATE=$(date +%Y-%m-%d-%H-%M-%S)
GC="-verbose:gc -XX:+PrintGCDateStamps -XX:+PrintGCDetails -Xloggc:$HADOOP_LOG_DIR/nn-gc-${DATE}.log"
NN_OPTS="-Xmx230g -Xms230g -Xmn30g"
NN_OPTS="$NN_OPTS -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSScavengeBeforeRemark -XX:CMSInitiatingOccupancyFraction=80 -XX:PermSize=3g -XX:MaxPermSize=3g -XX:+CMSParallelRemarkEnabled -XX:ParallelGCThreads=20 -XX:ConcGCThreads=20 -XX:+UseCMSCompactAtFullCollection -XX:CMSFullGCsBeforeCompaction=10"
NN_OPTS="$NN_OPTS $GC"

DN_OPTS="-Xmx10g -Xms10g"
DN_OPTS="$DN_OPTS -XX:+UseParallelOldGC -XX:+UseParallelGC -XX:ParallelGCThreads=20"


export HADOOP_NAMENODE_OPTS="$JMX_OPTS=8006 $NN_OPTS"
export HADOOP_DATANODE_OPTS="$JMX_OPTS=8016 $DN_OPTS"
#export HADOOP_BALANCER_OPTS="$HADOOP_BALANCER_OPTS"
#export HADOOP_JOBTRACKER_OPTS="$JMX_OPTS=8007 $HADOOP_JOBTRACKER_OPTS"
#export HADOOP_TASKTRACKER_OPTS="$JMX_OPTS=8017 $HADOOP_TASKTRACKER_OPTS"

#export HADOOP_PID_DIR=/opt/app/hadoop/tmp

