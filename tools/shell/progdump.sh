#########################################################################
# File Name: progdump.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2020-06-23 17:14:13
#########################################################################
#!/bin/bash

for line in `ls /proc/$1/task`;
do
    cd /proc/$1/task/$line
    cat status|grep -E "Name|Pid"
    cd ..;
done
