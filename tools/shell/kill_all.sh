#########################################################################
# File Name: kill_all.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2020-10-16 11:07:09
#########################################################################
#!/bin/bash

#ps -aux |grep nuttx|grep sudo |awk '{print $2}'|xargs -i sudo kill -9 {}

pids=`ps -aux |grep $1 |awk '{print $2}'|xargs`
echo "kill -9 ${pids}"
if [ "xx${pids}" != "xx" ]; then
    kill -9 ${pids}
fi
