#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Sync Repos and Trees"
cd /tmp/cirrus-ci-build/rom
repo init -q --no-repo-verify --depth=1 -u https://github.com/crdroidandroid/android.git -b 10.0
git clone --depth 1 https://github.com/leon4rd/local_manifests.git -b crdroid/10 .repo/local_manifests
repo sync --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -j1 --fail-fast
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Sync Repos and Trees Finish"
