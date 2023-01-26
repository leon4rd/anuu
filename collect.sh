#!/bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Collect Build"
cd /tmp/cirrus-ci-build/rom
source build/envsetup.sh
breakfast onclite userdebug
export TZ='Asia/Jakarta'
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
brunch onclite userdebug &
sleep 80m
jobs && jobs -p && kill % && kill %1 && kill -9 $(jobs -p) && killall -9 $(jobs -p)
ccache -s
cd /tmp/cirrus-ci-build
