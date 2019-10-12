OUT_DIR=sign_apk
WORK_SPACE=/home/eric/work_code/projs_src/lx04
mkdir $OUT_DIR
cp $WORK_SPACE/prebuilts/sdk/tools/darwin/lib64/libconscrypt_openjdk_jni.dylib $OUT_DIR/
cp $WORK_SPACE/prebuilts/sdk/tools/linux/lib64/libconscrypt_openjdk_jni.so $OUT_DIR/
cp $WORK_SPACE/prebuilts/sdk/tools/lib/signapk.jar $OUT_DIR/
cp $WORK_SPACE/build/make/target/product/security/platform.pk8 $OUT_DIR/
cp $WORK_SPACE/build/make/target/product/security/platform.x509.pem $OUT_DIR/
wget http://ci-miwifi.pt.xiaomi.com/jenkins/view/mico/job/MICO-Launcher-Daily/lastSuccessfulBuild/artifact/Archive/release/app-release.apk -O $OUT_DIR/MicoLauncher.apk
java -Djava.library.path=$OUT_DIR/ -jar $OUT_DIR/signapk.jar $OUT_DIR/platform.x509.pem $OUT_DIR/platform.pk8 $OUT_DIR/MicoLauncher.apk $OUT_DIR/MicoLauncher.s.apk


