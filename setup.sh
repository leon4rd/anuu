#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Setup Build"
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
git config --global user.email "apalotega02@gmail.com"; git config --global user.name "leon4rd"
mkdir -p $HOME/.config/rclone
echo "$rcloneconfig" > $HOME/.config/rclone/rclone.conf
mkdir -p /tmp/cirrus-ci-build/ccache
mkdir -p /tmp/cirrus-ci-build/rom
rclone copy drv:onclite/nad/10/ccache.tar.gz . -P
time tar xf ccache.tar.gz
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Setup Build Finish"
