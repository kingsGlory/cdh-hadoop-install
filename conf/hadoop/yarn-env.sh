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


# YARN HOME
export YARN_HOME=/usr/lib/hadoop-yarn

# User for YARN daemons
export HADOOP_YARN_USER=${HADOOP_YARN_USER:-yarn}

# resolve links - $0 may be a softlink
export YARN_CONF_DIR="${YARN_CONF_DIR:-$YARN_HOME/conf}"
export YARN_LIB_JARS_DIR="${YARN_LIB_JARS_DIR}:/usr/local/ext-yarn/*"

# some Java parameters
# export JAVA_HOME=/home/y/libexec/jdk1.6.0/
if [ "$JAVA_HOME" != "" ]; then
#echo "run java in $JAVA_HOME"
JAVA_HOME=$JAVA_HOME
fi

if [ "$JAVA_HOME" = "" ]; then
	JAVA_HOME=/usr/java/jdk1.7.0_75
fi

JAVA=$JAVA_HOME/bin/java
JAVA_HEAP_MAX=-Xmx2048m

# check envvars which might override default args
if [ "$YARN_HEAPSIZE" != "" ]; then
#echo "run with heapsize $YARN_HEAPSIZE"
JAVA_HEAP_MAX="-Xmx""$YARN_HEAPSIZE""m"
#echo $JAVA_HEAP_MAX
fi

# so that filenames w/ spaces are handled correctly in loops below
IFS=


# default log directory & file
if [ "$YARN_LOG_DIR" = "" ]; then
YARN_LOG_DIR="/opt/log/yarn"
fi
if [ "$YARN_LOGFILE" = "" ]; then
YARN_LOGFILE='yarn.log'
fi

# default policy file for service-level authorization
if [ "$YARN_POLICYFILE" = "" ]; then
YARN_POLICYFILE="hadoop-policy.xml"
fi

# restore ordinary behaviour
unset IFS

# export YARN_ROOT_LOGGER="${YARN_ROOT_LOGGER},CLHAYarn"

export YARN_JMX_BASE="-Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.port"
export YARN_XDEBUG_BASE=" -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address"

LOCAL_OPTS=" -Duser.language=zh -Duser.region=CN -Duser.timezone=Asia/Shanghai -Dfile.encoding=UTF-8 "

YARN_OPTS="$YARN_OPTS -Dhadoop.log.dir=$YARN_LOG_DIR"
YARN_OPTS="$YARN_OPTS -Dyarn.log.dir=$YARN_LOG_DIR"
YARN_OPTS="$YARN_OPTS -Dhadoop.log.file=$YARN_LOGFILE"
YARN_OPTS="$YARN_OPTS -Dyarn.log.file=$YARN_LOGFILE"
YARN_OPTS="$YARN_OPTS -Dyarn.home.dir=$YARN_COMMON_HOME"
YARN_OPTS="$YARN_OPTS -Dyarn.id.str=$YARN_IDENT_STRING"
YARN_OPTS="$YARN_OPTS -Dhadoop.root.logger=${YARN_ROOT_LOGGER:-INFO,console}"
YARN_OPTS="$YARN_OPTS -Dyarn.root.logger=${YARN_ROOT_LOGGER:-WARN,console}"
YARN_OPTS="$YARN_OPTS $LOCAL_OPTS "

#export YARN_RESOURCEMANAGER_OPTS="${YARN_JMX_BASE}=8026 ${YARN_XDEBUG_BASE}=19903 "
#export YARN_NODEMANAGER_OPTS="${YARN_JMX_BASE}=8036 ${YARN_XDEBUG_BASE}=19904 "
GC="-XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSScavengeBeforeRemark -XX:CMSInitiatingOccupancyFraction=65 -XX:+CMSParallelRemarkEnabled -XX:MaxGCPauseMillis=400 -verbose:gc -XX:+DisableExplicitGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/opt/log/yarn/gc-rm-${DATE}.log -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp"

export YARN_RESOURCEMANAGER_OPTS="-server -Xmx200g -Xms200g -Xmn60g -XX:PermSize=1g ${YARN_JMX_BASE}=8026 $GC"
export YARN_NODEMANAGER_OPTS=" -Xms4096m -Xmx4096m ${YARN_JMX_BASE}=8036 -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp"

if [ "x$JAVA_LIBRARY_PATH" != "x" ]; then
YARN_OPTS="$YARN_OPTS -Djava.library.path=$JAVA_LIBRARY_PATH"
fi
YARN_OPTS="$YARN_OPTS -Dyarn.policy.file=$YARN_POLICYFILE"

export YARN_LOG_DIR="/opt/log/yarn"

