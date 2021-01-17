#########################################################################
# File Name: kernel.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2021-01-17 14:45:56
#########################################################################
#!/bin/bash

uname -a
sleep 2

dpkg --get-selections | grep -E "linux-headers|linux-image|linux-modules" |grep -v 5.8.0-38 | awk '{print $1}' |xargs sudo apt-get -y remove pure
dpkg --get-selections | grep -E "linux-headers|linux-image|linux-modules" |grep -v 5.8.0-38 | awk '{print $1}' |xargs sudo dpkg -P

dpkg --get-selections | grep -E "linux-headers|linux-image|linux-modules"
