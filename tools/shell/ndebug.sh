#########################################################################
# File Name: ndebug.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2019-12-05 12:22:38
#########################################################################
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "$0 on | off"
    exit 0
fi

if [ $1 != "on" -a $1 != "off" ]; then
    echo "$0 on | off"
    exit 0
fi

if [ $1 == "on" ]; then
    sed -i "s/\/\/#define LOG_NDEBUG 0/#define LOG_NDEBUG 0/g" `grep "#define LOG_NDEBUG 0" -rl .`
else
    sed -i "s/#define LOG_NDEBUG 0/\/\/#define LOG_NDEBUG 0/g" `grep "#define LOG_NDEBUG 0" -rl .`
fi
