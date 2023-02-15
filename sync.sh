#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Sync Repos and Trees"
echo "+==========+==========+"
cd /tmp/cirrus-ci-build/rom
echo "$ghtokena" | gh auth login --with-token
gh auth status
echo "+==========+==========+"
repo init -q --no-repo-verify --depth=1 -u https://github.com/LineageOS/android.git -b lineage-20.0
git clone --depth 1 https://github.com/leon4rd/local_manifests.git -b los/13 .repo/local_manifests
repo sync --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -j1 --fail-fast
echo "+==========+==========+"
gh auth logout --hostname github.com
echo "+==========+==========+"
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Sync Repos and Trees Finish"
echo "+==========+==========+"
