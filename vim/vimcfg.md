### install vim
```
~$ sudo apt-get install vim
```

### config vim
  - cscope
  ```
  ~$ sudo apt-get install cscope
  ```
  - universal-ctags
  ```
  ~$ git clone https://github.com/universal-ctags/ctags
  ~$ cd ctags
  ~$ ./autogen.sh
  ~$ ./configure --prefix=/home/eric/tools/universal-ctags
  ~$ make -j8 & make install
  ~$ ln -s ~/tools/universal-ctags/bin/ctags ~/bin/ctags
  ```
  - gtags -- not use
  ```
  ~$ wget https://ftp.gnu.org/pub/gnu/global/latest.tar.gz
  ~$ tar -zxvf latest.tar.gz
  ~$ cd global
  ~$ ./configure --prefix=/home/eric/tools/gtags --with-sqlite3
  ~$ make -j16 & make install
  ~$ ln -s /home/eric/tools/gtags/bin/gtags /home/eric/bin/gtags
  ~$ ln -s /home/eric/tools/gtags/bin/gtags-cscope /home/eric/bin/gtags-cscope
  ```
  - gitvim
  ```
  ~$ git clone git@github.com:xulongqiu/gitvim.git
  ```
  - Vundle.vim
  ```
  ~$ mkdir ~/.vim/bundle;cd ~/.vim/bundle
  ~$ git clone https://github.com/VundleVim/Vundle.vim.git
  ```
  - clang
  ```
  ~$ sudo apt-get install clang
  ~$ clang -v
  ```
  - libs
  ```
  ~$ sudo apt-get install build-essential cmake python-dev python3-dev gcc ctags
  ```
  - .vimrc
  ```
  ~$ echo "source ~/gitvim/.vimrc-private" > ~/.vimrc
  ```
  - install bundle plugins
  ```
  ~$ vim
     :BundleInstall
  ```
  - build YCM
  ```
  ~$ cd ~/.vim/bundle/YouCompleteMe
  ~$ ./install.py --clang-completer --system-libclang
  ```

