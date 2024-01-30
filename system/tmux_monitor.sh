#!/bin/bash

session="sys"
tmux kill-session -t $session
tmux new-session -d -s $session

# network monitoring
tmux new-window -t $session:1 -n "network"
tmux send-keys -t $session:1 "$HOME/.scripts/wifi_check.sh" C-m
tmux join-pane -s $session:1 -t $session:0 

