#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Setup Build"
export DEBIAN_FRONTEND=noninteractive
mkdir -p $HOME/.config/rclone
echo "$rcloneconfig" > $HOME/.config/rclone/rclone.conf
mkdir -p /tmp/cirrus-ci-build/ccache
mkdir -p /tmp/cirrus-ci-build/rom
#rclone copy drv:onclite/crdroid/10/ccache.tar.gz . -P
#time tar xf ccache.tar.gz
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Setup Build Finish"
