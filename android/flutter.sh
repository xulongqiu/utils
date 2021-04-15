#########################################################################
# File Name: flutter.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2021-04-14 13:20:36
#########################################################################
#!/bin/bash

export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
git clone -b stable https://github.com/flutter/flutter.git
export PATH="$PWD/flutter/bin:$PATH"
cd ./flutter
git checkout v1.9.1-hotfixes
flutter doctor
