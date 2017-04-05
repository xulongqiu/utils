# Instant Messaging(IM)

## Skype for Linux
### Install
1. Open terminal by pressing **Ctrl+Alt+T** or searching for “terminal” from the Dash. When it opens, run command:
```
~$ dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y"
```
2. Run command to install the GPG key:
```
~$ curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
```
3. Add Skype repository to your system:
```
~$ echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skype-stable.list
```
4. After adding the repository, you can install Skype for Linux either via Synaptic Package Manager or by running command:
```
sudo apt-get update && sudo apt-get install skypeforlinux
```
And future updates will be available in Software Updater along with other system updates.

### Uninstall
To remove the Skype repository, go to System Settings -> Software & Updates -> Other Software tab.
