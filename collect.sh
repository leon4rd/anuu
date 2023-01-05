#!/bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Collect Build"
cd /tmp/cirrus-ci-build/rom
source build/envsetup.sh
export CCACHE_DIR=/tmp/cirrus-ci-build/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 10G
ccache -o compression=true
ccache -z
lunch nad_onclite-userdebug
mka nad -j$(nproc --all) &
sleep 88m
kill %
ccache -s
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Collect Build Finish"
