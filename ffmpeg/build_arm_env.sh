#########################################################################
# File Name: build_arm_env.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2019-09-27 17:32:00
#########################################################################
#!/bin/bash

NDK=~/tools/android-ndk-r13b

if [ "$NDK" = "" ]; then
    echo 'please set NDK variable first'
    exit 1
elif ! [ -d $NDK ]; then
    echo "NDK directory($NDK) is invaid"
    exit 1
fi

if [ "$SYSROOT" = "" ]; then
    if [ -d $NDK/platforms/android-19/arch-arm ]; then
        SYSROOT=$NDK/platforms/android-19/arch-arm
    else
        echo 'please set SYSROOT variable first'
        exit 1
    fi
fi

if [ "$TOOLCHAIN" = "" ]; then
    TOOLCHAIN=`echo $NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86*`
    if [ "$TOOLCHAIN" = "" ]; then
        echo 'please set TOOLCHAIN variable first'
        exit 1
    fi
fi

export PATH=$TOOLCHAIN/bin:$PATH

if [ "$SANDBOX" = "" ]; then
    SANDBOX=~/work_source/projs_src/lx04
fi
if [ "$PRODUCT" = "" ]; then
    PRODUCT="mi_lx04"
fi

