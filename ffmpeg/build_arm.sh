#########################################################################
# File Name: build_arm.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2019-09-27 17:30:50
#########################################################################
#!/bin/bash

# include ./arm-build-env.sh first
source ./build_arm_env.sh

echo "VAR[NDK]=$NDK"
echo "VAR[SYSROOT]=$SYSROOT"
echo "VAR[TOOLCHAIN]=$TOOLCHAIN"
echo "VAR[SANDBOX]=$SANDBOX"
echo "VAR[PRODUCT]=$PRODUCT"

FF_DEP_SYSTEM_LIB=$SANDBOX/out/target/product/${PRODUCT}/system/lib
FF_DEP_OPENSSL_INC=$SANDBOX/external/openssl/include
if [ -d $SANDBOX/external/boringssl/src/include ]; then
    FF_DEP_OPENSSL_INC=$SANDBOX/external/boringssl/src/include
fi
FF_DEP_LIBOPUS_INC=$SANDBOX/external/libopus/include

cur_dir=`pwd`
build_dir="../../ffmpeg_build/`basename $cur_dir`"
if [ -d $build_dir ]; then
    rm -rf $build_dir
fi
mkdir -p $build_dir

WORKING_DIR="$build_dir/ext_libs"
function support_openssl()
{
    if [ -f "${FF_DEP_SYSTEM_LIB}/libssl.so" ] && [ -f "${FF_DEP_SYSTEM_LIB}/libcrypto.so" ]; then
        echo "OpenSSL detected"
        mkdir -p $WORKING_DIR/openssl/lib
        mkdir -p $WORKING_DIR/openssl/include
        cp ${FF_DEP_SYSTEM_LIB}/libssl.so $WORKING_DIR/openssl/lib
        cp ${FF_DEP_SYSTEM_LIB}/libcrypto.so $WORKING_DIR/openssl/lib
        cp -r ${FF_DEP_OPENSSL_INC}/openssl $WORKING_DIR/openssl/include
	    FLAGS="$FLAGS --enable-openssl"
        EXTRA_CFLAGS="$EXTRA_CFLAGS -I${WORKING_DIR}/openssl/include"
        EXTRA_LDFLAGS="$EXTRA_LDFLAGS -L${WORKING_DIR}/openssl/lib -lssl -lcrypto"
    fi
}
function support_libopus()
{
    if [ -f "${FF_DEP_SYSTEM_LIB}/libopus.so" ]; then
        echo "libopus detected"
        mkdir -p $WORKING_DIR/libopus/lib
        mkdir -p $WORKING_DIR/libopus/include
        cp ${FF_DEP_SYSTEM_LIB}/libopus.so $WORKING_DIR/libopus/lib
        cp -r ${FF_DEP_LIBOPUS_INC}/*.h $WORKING_DIR/libopus/include
	    FLAGS="$FLAGS --enable-libopus --enable-demuxer=ogg --enable-muxer=ogg --enable-decoder=libopus"
        EXTRA_CFLAGS="$EXTRA_CFLAGS -I${WORKING_DIR}/libopus/include"
        EXTRA_LDFLAGS="$EXTRA_LDFLAGS -L${WORKING_DIR}/libopus/lib -lopus"
    fi
}

#FLAGS="$FLAGS --enable-small --optimization-flags=-O2"
# Don't build any neon version for now
for version in armv7a; do

	FLAGS="--target-os=linux --cross-prefix=arm-linux-androideabi- --arch=arm"
	FLAGS="$FLAGS --sysroot=$SYSROOT"
	FLAGS="$FLAGS --disable-everything"
	FLAGS="$FLAGS --enable-avresample"
	FLAGS="$FLAGS --enable-muxer=flac,wav,mp3,pcm_s16le,hls"
	FLAGS="$FLAGS --enable-encoder=flac,wmav1,wmav2,wmavoice,mp3,pcm_s16le,wav,aac"
	FLAGS="$FLAGS --enable-demuxer=ac3,aac,flac,h263,h264,m4v,matroska,mp3,mpegvideo,ogg,pcm_alaw,pcm_f32be,pcm_f32le,pcm_f64be,pcm_f64le,pcm_mulaw,pcm_s16be,pcm_s16le,pcm_s24be"
	FLAGS="$FLAGS --enable-demuxer=pcm_s24le,pcm_s32be,pcm_s32le,pcm_s8,pcm_u16be,pcm_u16le,pcm_u24be,pcm_u24le,pcm_u32be,pcm_u32le,pcm_u8,rtp,rtsp,sdp,wav,ape"
	FLAGS="$FLAGS --enable-demuxer=aiff,asf,dts,dtshd,xmv,xwma,hls"
	FLAGS="$FLAGS --enable-parser=ac3,aac,aac_latm,flac,h263,h264,mpegaudio,vorbis,vp8"
	FLAGS="$FLAGS --enable-decoder=ac3,aac,aac_latm,aasc,flac,mjpeg,mp3,vorbis,wmalossless,wmapro,wmav1,wmav2,wmavoice,ape"
	FLAGS="$FLAGS --enable-decoder=pcm_s24le,pcm_s32be,pcm_s32le,pcm_s8,pcm_u16be,pcm_u16le,pcm_u24be,pcm_u24le,pcm_u32be,pcm_u32le,pcm_u8,rtp,rtsp,sdp,wav,ape"
	FLAGS="$FLAGS --enable-decoder=pcm_alaw,pcm_f32be,pcm_f32le,pcm_f64be,pcm_f64le,pcm_mulaw,pcm_s16be,pcm_s16le,pcm_s24be,alac"
	FLAGS="$FLAGS --enable-decoder=wavpack,wmv1,wmv2,wmv3,adpcm_ima_wav,adpcm_ima_amv,adpcm_4xm,mp2,mp1"
	FLAGS="$FLAGS --enable-protocol=file,http,https,mmsh,mmst,tcp,udp,rtp,srtp,ftp,rtmp,rtmpt,hls"
    FLAGS="$FLAGS --enable-filter=null,anull,aresample"
#	FLAGS="$FLAGS --disable-debug"

	case "$version" in
		neon)
			EXTRA_CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=neon"
			EXTRA_LDFLAGS="-Wl,--fix-cortex-a8"
			# Runtime choosing neon vs non-neon requires
			# renamed files
			ABI="armeabi-v7a"
			;;
		armv7a)
			EXTRA_CFLAGS="-march=armv7-a -mfloat-abi=softfp"
			EXTRA_LDFLAGS="-Wl,--fix-cortex-a8"
			ABI="armeabi-v7a"
            support_openssl
            #support_libopus
			;;
		*)
			EXTRA_CFLAGS=""
			EXTRA_LDFLAGS=""
			ABI="armeabi"
			;;
	esac
	build_dir="$build_dir/$ABI"
	FLAGS="$FLAGS --prefix=$build_dir"

	mkdir -p $build_dir
	echo $FLAGS --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" > $build_dir/info.txt
	./configure $FLAGS --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" | tee $build_dir/configuration.txt
	[ $PIPESTATUS == 0 ] || exit 1
	make clean
	make -j4 || exit 1
	make install || exit 1
done

AV_SRC_PATH=$SANDBOX/vendor/mi/frameworks/av/samples/ffplay
echo "copy libs and includes to : $AV_SRC_PATH"
cp -r $build_dir/lib $AV_SRC_PATH
cp -r $build_dir/include $AV_SRC_PATH
mkdir -p $AV_SRC_PATH/include/compat
cp ./fftools/cmdutils.c $AV_SRC_PATH
cp ./fftools/ffmpeg_filter.c $AV_SRC_PATH
cp ./config.h $AV_SRC_PATH/include
cp ./fftools/cmdutils.h $AV_SRC_PATH/include
cp ./fftools/ffmpeg.h $AV_SRC_PATH/include
cp ./compat/va_copy.h $AV_SRC_PATH/include/compat

:<< !
cp ./libavformat/ffm.h               $AV_SRC_PATH/include/libavformat/
cp ./libavformat/network.h           $AV_SRC_PATH/include/libavformat/
cp ./libavformat/os_support.h        $AV_SRC_PATH/include/libavformat/
cp ./libavformat/url.h               $AV_SRC_PATH/include/libavformat/
cp ./libavformat/rtpdec.h            $AV_SRC_PATH/include/libavformat/
cp ./libavformat/srtp.h              $AV_SRC_PATH/include/libavformat/
cp ./libavformat/rtspcodes.h         $AV_SRC_PATH/include/libavformat/
cp ./libavformat/rtsp.h              $AV_SRC_PATH/include/libavformat/
cp ./libavformat/rtpproto.h          $AV_SRC_PATH/include/libavformat/
cp ./libavformat/rtp.h               $AV_SRC_PATH/include/libavformat/
cp ./libavformat/internal.h          $AV_SRC_PATH/include/libavformat/
cp ./libavformat/httpauth.h          $AV_SRC_PATH/include/libavformat/
cp ./libavformat/avio_internal.h     $AV_SRC_PATH/include/libavformat/
cp ./libavformat/playtree/playtree.h $AV_SRC_PATH/include/libavformat/
cp ./libavutil/libm.h                $AV_SRC_PATH/include/libavutil/
!
