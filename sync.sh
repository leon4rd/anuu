#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Sync Repos and Trees"
cd /tmp/cirrus-ci-build/rom
#echo "$ghtokena" > mt.txt
#gh auth login --git-protocol https --with-token < mt.txt
repo init -q --no-repo-verify --depth=1 -u https://github.com/NusantaraProject-ROM/android_manifest.git -b 11
#rm -f .repo/manifests/default.xml && wget -q -O .repo/manifests/default.xml https://raw.githubusercontent.com/leon4rd/manifests/nad/10/default.xml
git clone --depth 1 https://github.com/leon4rd/local_manifests.git -b nad/11 .repo/local_manifests
repo sync --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -j1 --fail-fast
#gh auth logout --hostname github.com
#sudo rm -f mt.txt
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Sync Repos and Trees Finish"
