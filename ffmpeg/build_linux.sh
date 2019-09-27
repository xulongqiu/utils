#########################################################################
# File Name: build_linux.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2019-09-27 17:35:43
#########################################################################
#!/bin/bash

#cd ~/ffmpeg_sources
#wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
#tar xjvf ffmpeg-snapshot.tar.bz2
#cd ffmpeg

#--pkg-config-flags="--static" \
#--extra-cflags="-I../../ffmpeg_build/include" \
#--disable-libx265 \
#--extra-ldflags="-L../../ffmpeg_build/lib"
cur_dir=`pwd`
build_dir="../../ffmpeg_build/`basename $cur_dir`"
if [ -d $build_dir ]; then
    rm -rf $build_dir
fi
mkdir -p $build_dir
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="../../ffmpeg_build/lib/pkgconfig" ./configure \
--prefix=$build_dir \
--bindir="$HOME/bin" \
--enable-gpl \
--enable-libass \
--enable-libfdk-aac \
--enable-libfreetype \
--enable-libmp3lame \
--enable-libopus \
--enable-libtheora \
--enable-libvorbis \
--disable-libvpx \
--enable-libx264 \
--enable-nonfree \
--enable-ffplay \
--enable-muxer=hls \
--enable-demuxer=hls \
--enable-protocol=hls,https,cache \
--enable-openssl
PATH="$HOME/bin:$PATH" make -j8
make install
make distclean
hash -r
