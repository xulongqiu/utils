#########################################################################
# File Name: build_mac.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2021-04-19 13:01:25
#########################################################################
#!/bin/bash

#cd ~/ffmpeg_sources
#wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
#tar xjvf ffmpeg-snapshot.tar.bz2
#cd ffmpeg

# https://trac.ffmpeg.org/wiki/CompilationGuide/macOS
# brew install faac fdk-aac lame x264 x265 speex pkg-config sdl2 libass libtool libvorbis libvpx libvo-aacenc opencore-amr openjpeg opus schroedinger shtool texi2html theora xvid yasm
cur_dir=`pwd`
build_dir="../ffmpeg_build/`basename $cur_dir`"
if [ -d $build_dir ]; then
    rm -rf $build_dir
fi
mkdir -p $build_dir
PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig":${PKG_CONFIG_PATH}
PATH="$HOME/bin:$PATH" ./configure \
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
--enable-openssl   \
--enable-protocol=crypto \
--extra-cflags=-I/usr/local/opt/openssl@1.1/include \
--extra-ldflags=-L/usr/local/opt/openssl@1.1/lib

PATH="$HOME/bin:$PATH" make -j8
make install
make distclean
hash -r
