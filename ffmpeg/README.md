### install on linux
- install libs
```
sudo apt-get -y install openssl libssl-dev autoconf automake build-essential libass-dev libfreetype6-dev   libsdl2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev   libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev yasm libx264-dev libx265-dev libfdk-aac-dev libmp3lame-dev libopus-dev
```

- down load ffmpeg source files
```
cd ~/ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot-git.tar.bz2   or
axel -n 20 http://ffmpeg.org/releases/ffmpeg-snapshot-git.tar.bz2
tar xjvf ffmpeg-snapshot-git.tar.bz2
cd ffmpeg
```
- build
```
cp ~/work_source/github/utils/ffmpeg/*.sh .
```
   vi build_linux.sh
```
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" /configure \
    --prefix="$HOME/ffmpeg_build" \
    --pkg-config-flags="--static" \
    --extra-cflags="-I$HOME/ffmpeg_build/include" \
    --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
    --bindir="$HOME/bin" \
    --enable-gpl \
    --enable-libass \
    --enable-libfdk-aac \
    --enable-libfreetype \
    --enable-libmp3lame \
    --enable-libopus \
    --enable-libtheora \
    --enable-libvorbis \
    --enable-libvpx \
    --enable-libx264 \
    --enable-libx265 \
    --enable-nonfree
PATH="$HOME/bin:$PATH" make
make install
make distclean
hash -r
```
```
chmod u+x build_linux.sh
./build_linux.sh
```
