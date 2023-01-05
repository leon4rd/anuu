#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Sync Repos and Trees"
cd /tmp/cirrus-ci-build/rom
repo init -q --no-repo-verify --depth=1 -u https://github.com/NusantaraProject-ROM/android_manifest.git -b 10
rm .repo/manifests/default.xml && wget -P .repo/manifests/ https://raw.githubusercontent.com/leon4rd/manifests/nad/10/default.xml
git clone --depth 1 https://github.com/leon4rd/local_manifests.git -b nad/10 .repo/local_manifests
repo sync --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -j1 --fail-fast
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Sync Repos and Trees Finish"
