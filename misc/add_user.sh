#!/bin/bash
set -e
set -x

NORMAL_USER=${1:-$NORMAL_USER}
echo "Add user ${NORMAL_USER}"

if id -u ${NORMAL_USER} >/dev/null 2>&1; then
    echo "User ${NORMAL_USER} already exists"
    exit 0
fi

mkdir -p /data
useradd -md /data/${NORMAL_USER} -s /bin/bash ${NORMAL_USER}
echo ${NORMAL_USER}:${NORMAL_USER}@123 | chpasswd
chage -d 0 $NORMAL_USER

sudo -u ${NORMAL_USER} /usr/local/miniconda3/bin/conda init bash
sudo -u ${NORMAL_USER} /usr/local/miniconda3/bin/conda config --set auto_activate_base false
#sudo -u ${NORMAL_USER} /usr/local/miniconda3/bin/conda config clean -i -y
sudo -u ${NORMAL_USER} cp ./sources/.condarc /data/${NORMAL_USER}/.condarc
sudo -u ${NORMAL_USER} /usr/local/miniconda3/bin/conda run pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
