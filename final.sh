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
lunch nad_onclite-userdebug
mka nad -j$(nproc --all)
ccache -s
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(ls /tmp/cirrus-ci-build/rom/out/target/product/onclite/Nusantara*.zip) Completed!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Uploading Build $(ls /tmp/cirrus-ci-build/rom/out/target/product/onclite/Nusantara*.zip)"
time rclone copy /tmp/cirrus-ci-build/rom/out/target/product/onclite/Nusantara*.zip drv:onclite/nad/10/ -P
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Build $(ls /tmp/cirrus-ci-build/rom/out/target/product/onclite/Nusantara*.zip) Uploaded Successfully!"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Download link https://crimson-sunset-175c.chestereckhart2871.workers.dev/0:/onclite/nad/10/$(ls /tmp/cirrus-ci-build/rom/out/target/product/onclite/Nusantara*.zip)"
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Final Scripts Finish"
