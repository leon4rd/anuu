#!/bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Final Scripts"
cd /tmp/cirrus-ci-build/rom
export CCACHE_DIR=/tmp/cirrus-ci-build/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 10G
ccache -o compression=true
ccache -z
source build/envsetup.sh
breakfast onclite userdebug
brunch onclite userdebug -j$(nproc --all)
ccache -s
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls crDroidAndroid*onclite*.zip) Completed!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Uploading Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls crDroidAndroid*onclite*.zip)"
time rclone copy /tmp/cirrus-ci-build/rom/out/target/product/onclite/crDroidAndroid*onclite*.zip drv:onclite/crdroid/10/ -P
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls crDroidAndroid*onclite*.zip) Uploaded Successfully!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Download link https://crimson-sunset-175c.chestereckhart2871.workers.dev/0:/onclite/crdroid/10/$(cd /tmp/cirrus-ci-build/rom/out/target/product/onclite && ls crDroidAndroid*onclite*.zip)"
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Final Scripts Finish"
