#!/bin/bash

mkdir /home/ubuntu/.scripts
mkdir /home/ubuntu/.log
cp tmux_monitor.sh /home/ubuntu/.scripts/
ln -s $PWD/wired_check.sh /home/ubuntu/.scripts/
ln -s $PWD/wifi_check.sh /home/ubuntu/.scripts/

apt install ssmtp sharutils

cp /home/ubuntu/ssmtp.conf /etc/ssmtp/1.conf && mv /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.bak && mv /etc/ssmtp/1.conf /etc/ssmtp/ssmtp.conf && chown $(whoami) /etc/ssmtp/ssmtp.conf
