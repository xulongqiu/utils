### install vim
```
~$ sudo apt-get install vim
```

### config vim
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
  ~$ sudo apt-get install build-essential cmake python-dev python3-dev
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

