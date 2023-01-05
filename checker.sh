#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Checker"
df -h
lsblk
ls -liah
pwd
rm -rf ccache.tar.gz
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Checker Finish"
