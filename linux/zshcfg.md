### install zsh
```
~$ sudo apt-get install zsh
```

### config zsh
  - install on-my-zsh
  ```
  ~$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```
  - install zplug
  ```
  ~$ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  ```
  - install nerd fonts
  ```
  ~$ cd ~/.local/share/fonts/
  ~$ mkdir scp
  ~$ axel -n 20 'https://github.com/ryanoasis/nerd-fonts/releases/SourceCodePro.zip'
  ~$ unzip SourceCodePro.zip
  ~$ sudo mkfontscale
  ~$ sudo mkfontdir
  ~$ sudo fc-cache fv
  ```
  - .zshrc
  ```
  ~$ echo "[ -f ~/gitvim/.zshrc-private ] && source ~/gitvim/.zshrc-private" >> ~/.zshrc
  ```

### change sh to zsh
```
~# chsh -s `which zsh`
```
