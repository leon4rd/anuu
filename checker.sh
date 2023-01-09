#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Checker"
ls -l -i -a -h
rm -rf ccache.tar.gz
pwd
df -kh
ls -l -i -a -h
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Checker Finish"
