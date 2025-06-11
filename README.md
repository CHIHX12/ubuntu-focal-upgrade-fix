# ubuntu-focal-upgrade-fix
🛠️ Scripts for fixing common upgrade issues when migrating from **Ubuntu 18.04 (bionic)** to **Ubuntu 20.04 (focal)**.  
Includes automated APT source migration, GPG key fixes, GNOME desktop recovery, and reboot diagnostics.

---

## 📂 Script Overview

| Script Name                     | Description                                                                 |
|--------------------------------|-----------------------------------------------------------------------------|
| `update_sources_focal_full.sh`     | Replaces `/etc/apt/sources.list` with Ubuntu 20.04 (focal) sources and adds support for CUDA, MariaDB, and MySQL repositories |
| `fix_bionic_upgrade_to_focal.sh`   | Cleans up legacy `bionic` sources, unholds broken packages, and reinstalls a working GNOME desktop environment |
| `reboot_diagnose.sh`               | Diagnoses why `reboot` or `loginctl` might not work and offers interactive repair for `systemd`, `dbus`, and `logind` |

---

## 🚀 How to Use

### 1. Clone the repository

```bash
git clone https://github.com/CHIHX12/ubuntu-focal-upgrade-fix.git
cd ubuntu-focal-upgrade-fix
chmod +x *.sh

# Step 1: Switch APT sources to Ubuntu 20.04 and add key repositories
./update_sources_focal_full.sh

# Step 2: Remove legacy bionic packages and fix GNOME conflicts
./fix_bionic_upgrade_to_focal.sh

# Step 3: (Optional) If reboot does not work, run diagnostic
./reboot_diagnose.sh
