#########################################################################
# File Name: copy.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2019-05-15 21:11:00
#########################################################################
#!/bin/bash

if [ $# -eq 2 ] && [ -d $1 ] && [ -d $2 ]; then
    echo "will compare $1 and $2"
elif [ $# -eq 3 ] && [ -d $1 ] && [ -d $2 ] && [ $3 = "show" ]; then
    just_show=1
else
    echo "Usage: $0 dir1 dir2"
    exit 1
fi

echo "$1 has but $2 has not: "
for file in `ls $1`; do
    if ! [ -e $2/$file ]; then
        echo "$file"
        if [ "xx"$just_show = "xx" ]; then
            cp $1/$file $2
        fi
    fi
done

echo "$2 has but $1 has not: "
for file in `ls $2`; do
    if ! [ -e $1/$file ]; then 
        echo "$file"
        if [ "xx"$just_show = "xx" ]; then
            cp $2/$file $1
        fi
    fi
done
