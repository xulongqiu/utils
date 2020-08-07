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

date=`date +%Y-%m-%d`

#wget "https://smallfiles-cnbj1-fusion-fds.api.xiaomi.net/nlp-audio-storage/${date}/multi_channel_asr/310807211611790336/${1}-horizon" -o ${1}_multi_asr.opus
wget "https://smallfiles-cnbj1-fusion-fds.api.xiaomi.net/nlp-audio-storage/2019-05-14/multi_channel_asr/310807211611790336/${1}-horizon" -O ${1}_multi_asr.opus
