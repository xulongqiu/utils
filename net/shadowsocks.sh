#########################################################################
# File Name: shadowsocks.sh
# Author: eric.xu
# mail: eric.xu@libratone.com.cn
# Created Time: 2017年03月01日 星期三 00时25分43秒
#########################################################################
#!/bin/bash

sslocal -s us03-80.ssv7.net -p 62315 -b 127.0.0.1 -l 1080 -k FzKYNn4W3vVF -m  aes-256-cfb -t 600
