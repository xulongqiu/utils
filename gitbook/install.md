## gitbook install

- ### install cnpm
  ```shell
  sudo npm install -g cnpm --registry=https://registry.npm.taobao.org
  ```

- ### install gitbook-cli
  ```shell
  sudo cnpm install -g gitbook-cli
  ```

- ### install gitbook-editor
  ```shell
  wget http://downloads.editor.gitbook.com/download/linux-64-bit
  dpkg -i gitbook-editor-7.0.12-linux-x64.deb
  ```

- ### install calibre-ebook
 ```shell
 sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
  ```
- start server
 ```shell
 gitbook serve
 ```

- convert to pdf
 ```shell
 gitbook pdf
 ```
