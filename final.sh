#!/bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Final Scripts"
cd /tmp/cirrus-ci-build/rom
export TZ='Asia/Jakarta' date
export BUILD_HOSTNAME=cirrus
export BUILD_USERNAME=jammy
export KBUILD_BUILD_HOST=cirrus
export KBUILD_BUILD_USER=jammy
source build/envsetup.sh
export CCACHE_DIR=/tmp/cirrus-ci-build/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 10G
ccache -o compression=true
ccache -z
lunch nad_onclite-userdebug
mka api-stubs-docs || echo "no problem"
mka hiddenapi-lists-docs || echo "no problem"
mka system-api-stubs-docs || echo "no problem"
mka test-api-stubs-docs || echo "no problem"
mka nad -j10
ccache -s
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls Nusantara*.zip) Completed!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Uploading Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls Nusantara*.zip)"
time rclone copy /tmp/cirrus-ci-build/rom/out/target/product/onclite/Nusantara*.zip drv:onclite/nad/10/ -P
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls Nusantara*.zip) Uploaded Successfully!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Download link https://crimson-sunset-175c.chestereckhart2871.workers.dev/0:/onclite/nad/10/$(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls Nusantara*.zip))"
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Final Scripts Finish"
