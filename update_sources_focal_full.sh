#!/bin/bash
set -e

echo "📦 備份現有 /etc/apt/sources.list ..."
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup.$(date +%Y%m%d-%H%M%S)

echo "📝 更新 Ubuntu sources.list 為 focal ..."
sudo tee /etc/apt/sources.list > /dev/null <<EOF
deb http://tw.archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb http://tw.archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://tw.archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu focal-security main restricted universe multiverse
EOF

echo "🧹 移除過期來源（TeamViewer、MariaDB、MySQL、Google Chrome、NVIDIA）..."
sudo rm -f /etc/apt/sources.list.d/*teamviewer*
sudo rm -f /etc/apt/sources.list.d/*chrome*
sudo rm -f /etc/apt/sources.list.d/*mariadb*
sudo rm -f /etc/apt/sources.list.d/*mysql*
sudo rm -f /etc/apt/sources.list.d/*nvidia*

echo "🚀 新增 NVIDIA CUDA for Ubuntu 20.04 (focal) ..."
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository -y "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"

echo "🧬 新增 MariaDB 11.0 for focal（官方來源）..."
sudo apt install -y software-properties-common dirmngr ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://mariadb.org/mariadb_release_signing_key.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/mariadb.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mariadb.gpg] https://deb.mariadb.org/11.0/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/mariadb.list

echo "🐬 安裝 MySQL APT Config for focal ..."
wget https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb
sudo DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.29-1_all.deb
rm mysql-apt-config_0.8.29-1_all.deb

echo "🔄 更新套件清單 ..."
sudo apt update

echo "✅ 完成！sources.list 已更新為 focal，並成功加入 CUDA、MariaDB、MySQL 支援。"
