#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Checker"
ls -l -i -a -h
rm -rf ccache.tar.gz
#rm -rf $HOME/.config/rclone/rclone.conf
#echo "$rcloneconfiga" > $HOME/.config/rclone/rclone.conf
pwd
df -kh
ls -l -i -a -h
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="OS = $(cat /etc/*os* | grep NAME)"
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Checker Finish"
