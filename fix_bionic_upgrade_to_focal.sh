#!/bin/bash
set -e

echo "🔍 檢查是否存在殘留的 bionic 套件來源..."
sudo grep bionic /etc/apt/sources.list /etc/apt/sources.list.d/*.list || echo "✅ 無 bionic 來源"

echo "🧹 自動移除 bionic 相關來源（如果存在）..."
sudo sed -i '/bionic/d' /etc/apt/sources.list
for file in /etc/apt/sources.list.d/*.list; do
  sudo sed -i '/bionic/d' "$file"
done

echo "🔓 解除被 hold 的套件..."
dpkg --get-selections | grep hold | awk '{print $1}' | while read pkg; do
  echo " → 解除 $pkg"
  sudo apt-mark unhold "$pkg"
done

echo "🔄 更新套件清單與升級 focal 套件..."
sudo apt update
sudo apt dist-upgrade -y

echo "🧼 自動清除已過時的 GNOME 舊版本..."
sudo apt remove -y eog mutter gnome-session-common gsettings-desktop-schemas
sudo apt autoremove -y

echo "📦 重新安裝 focal 版 GNOME 桌面環境..."
sudo apt install -y ubuntu-desktop

echo "✅ 修復完成！已升級為 Ubuntu 20.04 focal 環境並移除 bionic 衝突套件。"
