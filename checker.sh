#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Checker"
ls -l -i -a -h
curl --progress-bar -F document=@"ccache.tar.gz" https://api.telegram.org/$tokentl/sendDocument -F chat_id=$idtl -F "disable_web_page_preview=true"
rm -rf ccache.tar.gz
rm -rf $HOME/.config/rclone/rclone.conf
echo "$rcloneconfiga" > $HOME/.config/rclone/rclone.conf
pwd
df -kh
ls -l -i -a -h
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Run On :: $(source /etc/os-release && echo "${NAME}")"
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Checker Finish"
