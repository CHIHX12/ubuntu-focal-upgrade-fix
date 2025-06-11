# ubuntu-focal-upgrade-fix
🛠️ Scripts for fixing Ubuntu 20.04 (focal) upgrade issues from Ubuntu 18.04 (bionic), including source list migration, GPG key setup, dependency resolution, and GNOME recovery.

# Ubuntu 20.04 升級修復工具包 🔧

本專案提供兩支腳本，專為從 Ubuntu 18.04（bionic）升級到 20.04（focal）後，仍殘留舊套件或來源所導致的錯誤進行 **一鍵修復與套件更新**。

---

## 📄 腳本說明

| 檔案名稱 | 說明 |
|----------|------|
| `update_sources_focal_full.sh` | 將 `/etc/apt/sources.list` 全面切換為 focal，並自動新增 CUDA、MariaDB、MySQL 等支援 |
| `fix_bionic_upgrade_to_focal.sh` | 移除殘留 bionic 來源、解除 hold 套件、修復 GNOME 相依問題、重建 focal 桌面環境 |

---

## 🚀 使用方式

1. **下載此專案**
   ```bash
   git clone https://github.com/CHIHX12/ubuntu-focal-upgrade-fix.git
   cd ubuntu-focal-upgrade-fix
