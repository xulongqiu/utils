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

date=2020-07-12
#appid=527449393826104320 #x08c
appid=530351618386821120 #x08e
#date=`date +%Y-%m-%d`
#ffplay -f s16le -ar 16000 -ac 1 -autoexit "https://smallfiles-cnbj1-fusion-fds.api.xiaomi.net/nlp-audio-storage/${date}/asr/310807211611790336/${1}-ByDefault"
ffplay -f s16le -ar 16000 -ac 1 -autoexit "https://smallfiles-cnbj1-fusion-fds.api.xiaomi.net/nlp-audio-storage/$1-$appid-asr-ByDefault-${date}"

