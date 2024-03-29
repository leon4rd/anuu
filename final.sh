#!/bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Final Scripts"
cd /tmp/cirrus-ci-build/rom
rm -f vendor/xiaomi/onclite/proprietary/vendor/lib/libsdm-color.so vendor/xiaomi/onclite/proprietary/vendor/lib64/libsdm-color.so
wget -q -P vendor/xiaomi/onclite/proprietary/vendor/lib https://raw.githubusercontent.com/zhantech/vt_tissot/10/msm8953-common/proprietary/vendor/lib/libsdm-color.so
wget -q -P vendor/xiaomi/onclite/proprietary/vendor/lib64 https://raw.githubusercontent.com/zhantech/vt_tissot/10/msm8953-common/proprietary/vendor/lib64/libsdm-color.so
cd /tmp/cirrus-ci-build/rom/device/xiaomi/onclite
python3 update-sha1sums.py
cd /tmp/cirrus-ci-build/rom
source build/envsetup.sh
lunch nad_onclite-userdebug
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
mka api-stubs-docs || echo "no problem"
mka hiddenapi-lists-docs || echo "no problem"
mka system-api-stubs-docs || echo "no problem"
mka test-api-stubs-docs || echo "no problem"
mka nad -j8
ccache -s
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls Nusantara*.zip) Completed!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Uploading Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls Nusantara*.zip)"
curl --progress-bar -F document=@"/tmp/cirrus-ci-build/rom/out/target/product/onclite/Nusantara*.zip" https://api.telegram.org/$tokentl/sendDocument -F chat_id=$idtl -F "disable_web_page_preview=true"
time rclone copy /tmp/cirrus-ci-build/rom/out/target/product/onclite/Nusantara*.zip drv:onclite/nad/10/ -P
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls Nusantara*.zip) Uploaded Successfully!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Download link https://crimson-sunset-175c.chestereckhart2871.workers.dev/0:/onclite/nad/10/$(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls Nusantara*.zip))"
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Final Scripts Finish"
