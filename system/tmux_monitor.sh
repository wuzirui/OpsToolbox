#!/bin/bash

session="sys"
tmux kill-session -t $session
tmux new-session -d -s $session

# network monitoring
tmux new-window -t $session:1 -n "network"
tmux send-keys -t $session:1 "$HOME/.scripts/wired_check.sh" C-m
tmux join-pane -s $session:1 -t $session:0 

# gpu and disk monitoring
tmux new-window -t $session:1 -n "gpu"
tmux send-keys -t $session:1 "gpustat -i" C-m
tmux join-pane -s $session:1 -t $session:0 
tmux new-window -t $session:1 -n "disk"
tmux send-keys -t $session:1 "watch df -h" C-m
tmux join-pane -s $session:1 -t $session:0
