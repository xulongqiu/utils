#########################################################################
# File Name: mvs.sh
# Author: eric.xu
# mail: xulongqiu@xiaomi.com
# Created Time: 2019-12-21 16:00:08
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
        echo "loopcheckfile -f $1"
        file=${1##*/}
        sufix=${file##*.}
        name=${file%.*}
        echo "file=$file, sufix=$sufix, name=$name"
        in_file_dir=${1%/*}
        echo "in_dir=$in_file_dir"
        sub_dir=${in_file_dir#*$in_dir}
        echo "sub_dir=$sub_dir"
        out_file_dir=$out_dir$sub_dir
        echo "out_file_dir=$out_file_dir"
        echo "find file: $1"
        if ! [ -d $out_file_dir ]; then
            mkdir -p $out_file_dir
        fi
        #cp $1 $out_file_dir/${name%$append_name*}.${sufix}
        if [ "$sufix" == "wav" ]; then
            ffmpeg -i $1 -acodec libopus -ac 1 -ar 16000 $out_file_dir/${name}.opus
        fi
    fi
}

for file in `ls $in_dir`; do
    echo "main loopcheckfile $in_dir/$file"
    loopcheckfile $in_dir/$file
done
