#!/bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Final Scripts"
cd /tmp/cirrus-ci-build/rom
#mkdir -p out && cd out
time rclone copy drv:onclite/los/13/out . -P
#cd ..
ls -l -i -a -h
#rm -f vendor/xiaomi/onclite/proprietary/vendor/lib/libsdm-color.so vendor/xiaomi/onclite/proprietary/vendor/lib64/libsdm-color.so
#wget -q -P vendor/xiaomi/onclite/proprietary/vendor/lib https://raw.githubusercontent.com/zhantech/vt_tissot/10/msm8953-common/proprietary/vendor/lib/libsdm-color.so
#wget -q -P vendor/xiaomi/onclite/proprietary/vendor/lib64 https://raw.githubusercontent.com/zhantech/vt_tissot/10/msm8953-common/proprietary/vendor/lib64/libsdm-color.so
#cd /tmp/cirrus-ci-build/rom/device/xiaomi/onclite
#python3 update-sha1sums.py
#cd /tmp/cirrus-ci-build/rom
source build/envsetup.sh
breakfast onclite userdebug
export TZ='Asia/Jakarta' date
export BUILD_HOSTNAME=cirrus
export BUILD_USERNAME=jammy
export KBUILD_BUILD_HOST=cirrus
export KBUILD_BUILD_USER=jammy
export CCACHE_DIR=/tmp/cirrus-ci-build/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 10G
ccache -o compression=true
ccache -z
mka bacon -j8 &
sleep 60m
jobs && jobs -p && kill % && kill %1 && kill -9 $(jobs -p) && killall -9 $(jobs -p)
ccache -s
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls lineage*.zip) Completed!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Uploading Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls lineage*.zip)"
time rclone copy /tmp/cirrus-ci-build/rom/out drv:onclite/los/13/ -P
time rclone copy /tmp/cirrus-ci-build/rom/out/target/product/onclite/lineage*.zip drv:onclite/los/13/ -P
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls lineage*.zip) Uploaded Successfully!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Download link https://crimson-sunset-175c.chestereckhart2871.workers.dev/0:/onclite/los/13/$(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls lineage*.zip))"
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Final Scripts Finish"
rm -rf /tmp/cirrus-ci-build/rom || echo "no problem"
