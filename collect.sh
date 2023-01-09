#!/bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Collect Build"
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
mka nad -j10 &
sleep 85m
kill %1
ccache -s
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Collect Build Finish"
