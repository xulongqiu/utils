#########################################################################
# File Name: playvoid.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2018-08-08 17:30:25
#########################################################################
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 request_id"
    exit 0
fi

#date=`date +%Y-%m-%d`
date=2019-07-25
appid=353933914248580096  #lx05
appid=310807211611790336  #lx04
#ffplay -f s16le -ar 16000 -ac 1 -autoexit "https://smallfiles-cnbj1-fusion-fds.api.xiaomi.net/nlp-audio-storage/${date}/wakeup/310807211611790336/${1}-hobot"
ffplay -f s16le -ar 16000 -ac 1 -autoexit "https://smallfiles-cnbj1-fusion-fds.api.xiaomi.net/nlp-audio-storage/${date}/wakeup/${appid}/${1}-horizon"
