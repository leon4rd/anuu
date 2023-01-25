#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Sync Repos and Trees"
echo "+==========+==========+"
cd /tmp/cirrus-ci-build/rom
echo "ENCRYPTED[2f8ce526ec63e1ac796966fee9c5f21294db3c5f349141e5108bf9b5976d5b7d4a15612050ca036c59f09f5dc37e9216]" | gh auth login --with-token
echo "+==========+==========+"
repo init -q --no-repo-verify --depth=1 -u https://github.com/Nusantara-ROM/android_manifest.git -b 12.1
rm -f .repo/manifests/snippets/nusantara.xml && wget -q -O .repo/manifests/snippets/nusantara.xml https://raw.githubusercontent.com/leon4rd/manifests/nad/12/snippets/nusantara.xml
git clone --depth 1 https://github.com/leon4rd/local_manifests.git -b nad/12 .repo/local_manifests
repo sync --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -j1 --fail-fast
echo "+==========+==========+"
gh auth logout --hostname github.com
echo "+==========+==========+"
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Sync Repos and Trees Finish"
echo "+==========+==========+"
