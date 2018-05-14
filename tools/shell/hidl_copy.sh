#########################################################################
# File Name: hidl_copy.sh
# Author: eric.xu
# mail: xulongqiu@xiaomi.com
# Created Time: 2018-05-14 15:02:16
#########################################################################
#!/bin/bash

if [ $# -ne 2 ] || ! [ -d $1 ] || ! [ -d $2 ]; then
    echo "Usage: $0 src_dir  out_dir"
    exit 0
fi

cd $1;in_dir=`pwd`;cd -
cd $2;out_dir=`pwd`;cd -
#echo "in_dir=$in_dir"
#echo "out_dir=$out_dir"

function loopcheckfile()
{
    if [ $# -ne 1 ]; then
        echo "loopcheckfile must be one parameter"
        return 1
    fi

    if ! [ -e $1 ]; then
        echo "ERROR: $1 not exist"
        return 1
    fi

    if [ -d $1 ]; then
        for file in `ls $1`; do
            #echo "loopcheckfile $1/$file"
            loopcheckfile $1/$file
        done 
       return 0
    fi
    if [ -f $1 ];then
        #echo "loopcheckfile -f $1"
        sufix=${1##*.}
        #echo "sufix=$sufix"
        dir=${1%/*}
        #echo "in_dir=$dir"
        dir=${dir#*$in_dir}
        #echo "mid_dir=$dir"
        dir=$out_dir$dir
        #echo "out_dir=$dir"
        if [ $sufix = "cpp" ] || [ $sufix = "h" ]; then
            #echo "find file: $1"
            if ! [ -d $dir ]; then
                mkdir -p $dir
            fi
            cp $1 $dir
        fi
    fi
}

for file in `ls $in_dir`; do
    echo "main loopcheckfile $in_dir/$file"
    loopcheckfile $in_dir/$file
done
