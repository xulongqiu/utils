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
appId=310807211611790336 #lx04
#appId=353933914248580096 #lx05
date=`date +%Y-%m-%d`
date=2019-07-25
#ffmpeg -f s16le -ar 16000 -ac 1 -i "https://smallfiles-cnbj1-fusion-fds.api.xiaomi.net/nlp-audio-storage/2019-05-15/wakeup/310807211611790336/${1}-horizon" ${1}_wakeup.wav
ffmpeg -f s16le -ar 16000 -ac 1 -i "https://smallfiles-cnbj1-fusion-fds.api.xiaomi.net/nlp-audio-storage/${date}/wakeup/${appId}/${1}-horizon" ${1}_wakeup.wav
