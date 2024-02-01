#!/bin/bash

mkdir $HOME/.scripts
mkdir $HOME/.log
cp tmux_monitor.sh $HOME/.scripts/
ln -s $PWD/wired_check.sh $HOME/.scripts/
ln -s $PWD/wifi_check.sh $HOME/.scripts/

apt install ssmtp sharutils

cp /home/ubuntu/ssmtp.conf /etc/ssmtp/1.conf && mv /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.bak && mv /etc/ssmtp/1.conf /etc/ssmtp/ssmtp.conf && chown $(whoami) /etc/ssmtp/ssmtp.conf
