#! /bin/bash

curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Start Setup Build"
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
echo 'set debconf to Noninteractive'
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
sudo apt update
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
git config --global user.email "apalotega02@gmail.com"; git config --global user.name "leon4rd"
mkdir -p $HOME/.config/rclone
echo "$rcloneconfig" > $HOME/.config/rclone/rclone.conf
mkdir -p /tmp/cirrus-ci-build/ccache
mkdir -p /tmp/cirrus-ci-build/rom
rclone copy drv:onclite/nad/12/ccache.tar.gz . -P
time tar xf ccache.tar.gz
sudo apt clean --dry-run
cd /tmp/cirrus-ci-build
curl -s https://api.telegram.org/$tokentl/sendMessage -d chat_id=$idtl -d text="Setup Build Finish"
