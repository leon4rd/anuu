#!/bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Compress Ccache"
sleep 5s
com ()
{
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz $1
}
time com ccache 1
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Compress Ccache Finish"
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Upload Ccache"
rclone copy ccache.tar.gz drv:onclite/nad/11/ -P
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Upload Ccache Finish"
sudo rm -rf /tmp/cirrus-ci-build/rom /tmp/cirrus-ci-build/*.log || echo "no problem"
