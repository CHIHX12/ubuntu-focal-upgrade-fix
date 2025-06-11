#!/bin/bash
set -e

echo "🩺 Reboot 指令診斷工具（含自動修復）"
echo "======================================="

# 1. 檢查 reboot 連結
echo -e "\n📍 /sbin/reboot 檢查:"
ls -l /sbin/reboot

# 2. 檢查 systemctl
echo -e "\n📍 /bin/systemctl 檢查:"
if [ -x /bin/systemctl ]; then
    echo "✅ /bin/systemctl 存在"
else
    echo "❌ systemctl 缺失，請手動修復 systemd 套件"
fi

# 3. systemctl reboot 測試（不會重啟）
echo -e "\n📍 測試 systemctl reboot（模擬 dry-run）："
systemctl --no-pager reboot --dry-run || echo "⚠️ 無法執行 systemctl reboot"

# 4. 查看 PID 1
echo -e "\n📍 啟動 PID 1 檢查："
PID1=$(ps -p 1 -o comm=)
echo "PID 1 啟動程式為：$PID1"

# 5. loginctl 測試
echo -e "\n📍 測試 loginctl："
if loginctl &>/dev/null; then
    echo "✅ loginctl 正常運作"
else
    echo "❌ loginctl 無法連接到 systemd-logind（可能是 dbus/systemd/logind 問題）"

    # 問使用者是否要進行修復
    read -p "❓ 是否執行一鍵修復 systemd + dbus + logind？ [Y/n]: " answer
    answer=${answer:-Y}

    if [[ $answer =~ ^[Yy]$ ]]; then
        echo -e "\n🔧 開始自動修復..."
        sudo apt update
        sudo apt install --reinstall -y dbus systemd systemd-sysv policykit-1
        echo "🔄 重啟 systemd-logind 服務..."
        sudo systemctl daemon-reexec
        sudo systemctl restart systemd-logind.service
        echo "✅ 修復完成。請再次執行 loginctl 或 sudo reboot 測試。"
    else
        echo "⚠️ 使用者選擇略過修復，請自行處理 dbus/systemd 設定。"
    fi
fi

# 6. 虛擬化偵測
echo -e "\n📍 虛擬化偵測："
systemd-detect-virt

# 7. reboot 路徑與 sudo 權限
echo -e "\n📍 reboot 路徑與使用者群組："
which reboot
groups

echo -e "\n✅ 診斷結束，請依據輸出資訊判斷 reboot 問題是否已排除。"
