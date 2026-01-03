# nixos-utm-hyprland

A **just-works** NixOS flake for **UTM on Apple Silicon (M1/M2/M3)** with **Hyprland** + **Home Manager** + **Disko** for a zero-touch install.

## Default credentials

- **User:** `thomas`
- **Password:** `thomas`

(You can change it later with `passwd`.)

## Install (fresh VM)

1. Create a UTM VM with an **ARM64** NixOS ISO (minimal is fine) and a virtual disk (e.g. 40–80 GB).
2. Boot the ISO, get a shell, and run:

```bash
# get networking (usually already up)
sudo -i
nix-shell -p git
git clone <YOUR_REPO_URL> /tmp/nixos-utm-hyprland
cd /tmp/nixos-utm-hyprland
bash scripts/install.sh
```

That script will:
- partition **/dev/vda** (UTM virtio disk)
- install NixOS using this flake (`#utm-m1`)
- reboot into Hyprland via a simple TUI login

## Update after install

```bash
sudo nixos-rebuild switch --flake /etc/nixos#utm-m1
```

## Notes
- If your disk is **not** `/dev/vda`, edit `hosts/utm-m1/disko.nix` accordingly.

## Host ↔ Guest shared folder (macOS ↔ VM)

This repo auto-mounts UTM’s **Shared Directory** at:

- `/mnt/share` (recommended; permission-mapped so it’s writable)

**One-time in UTM (UI):**
- VM Settings → **Sharing** → add a Shared Directory
- Set **Directory Share Mode** to **VirtFS** (QEMU backend), or **VirtioFS** (Apple virtualization backend)

UTM exposes the share under the fixed tag `share`, which this config mounts automatically. citeturn0search0turn0search8
