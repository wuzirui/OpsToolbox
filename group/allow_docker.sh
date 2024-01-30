#!/bin/bash
set -e
set -x

NORMAL_USER=${1:-$NORMAL_USER}
echo "Add user ${NORMAL_USER} to group docker"

sudo usermod -aG docker ${NORMAL_USER}
