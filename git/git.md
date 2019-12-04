# the usage of git

> 2017-03-26 

**git download/configure**
* sudo apt install git
* configure username and password
  ```
  git config --global user.name "xulongqiu"
  git config --global user.email "xulongqiu163@163.com"
  ```
* generate ssh key
  ```
  ssh-keygen -t rsa -C "xulongqiu163@163.com"
  login github
  Settings -> SSH and GPP keys -> SSH keys > New SSH key
  cat ~/.ssh/id_rsa.pub
  ```

> 2016-07-31 

**create remote repository:utils**
* click new button on the right of Repositories menu;
* write the repository name, descripton ... then click create repository button;
* create utils directroy on the local and then:
  ```
  cd utils
  git init
  echo "# Usage of utils" >> README.dm
  git commit -a -m "add the README.dm file"
  git remote add origin https://github.com/xulongqiu/utils.git 
  git push -u origin master
  ```
	
* add file or direcotry: git/ git.txt
  ```
  git add git/
  git add git/git.txt
  ```

* commit the change to local repository
  ```
  git commit -m "change logs"
  ```

* push the change to remote repository
  ```
  git push -u origin master
  ```

* check the git repository server address
  ```
  git remote -v
  ```

> 2017-03-26 

**add local repository to remote:**
* click new button on the right of Repositories menu;
* write the repository name, descripton ... then click create repository button;
* git remote set-url origin git@github.com:xulongqiu/raspberry-circle.git
* git push origin master
* git push git push origin eric_local:eric

**delete remote branch**:
* eric_local
  ```
  git push origin --delete eric_local
  ```

**har reset any commit**
* git log
  ```
  git reset --hard commit_num
  ```
* git reflog
  ```
  git reset --hard commit_num 
  ```

> 2017-09-14

report below error even though add the ssh key to git:
sign_and_send_pubkey: signing failed: agent refused operation
```
  eval "$(ssh-agent -s)"
  ssh-add
```

> 2017-11-14

delete local cached branch that has been removed at remote
```
  git remote prune origin
```

> 2019-12-04
* add more change with one commit history
  ```
  git commit --amend -m "new commit"   #with new commit messages
  git commit --amend --no-edit         #do not change commit messages
  ```  
* 为了对齐提交线，git push 之前尽量先git pull
  ```
  git pull orign xxx --rebase
  ```
* 暂存的使用
  ```
  git stash　# 暂存当前未add的修改
  git stash list # 查看暂存历史
  git stash pop  # 弹出最新一个缓存
  git stash drop # 丢弃最新一个缓存
  ```
* 修改提交作者
  ```
  git rebase -i HEAD~n
  change "pick" to "e" or "edit" of every line, then exit text-editor
  git commit --amend --author "xx <xx@yy.com>"
  git rebase --continue
  ```

