#########################################################################
# File Name: create.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2020-04-26 21:59:02
#########################################################################
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "$0 font.otf"
    exit 0
fi
# axel -n 50 'https://github.com/ryanoasis/nerd-fonts/archive/v2.1.0.zip'
# unzip nerd-fonts-2.1.0.zip
# cd nerd-fonts-2.1.0
# cp create.sh nerd-fonts-2.1.0
# ./create.sh ~/.local/share/font/courier/xxx.otf
# cd ~/.local/share/font/courier/
# sudo mkfontscale;sudo mkfontdir;sudo fc-cache -fv
fontforge -script font-patcher "$1" --use-single-width-glyphs --windows --fontawesome --octicons --fontlinux --pomicons --powerlineextra --fontawesomeextension --powersymbols --weather --material
