#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Please run as root (sudo -i)"; exit 1
fi

DISK="/dev/vda"
if [[ ! -b "$DISK" ]]; then
  echo "Expected disk $DISK not found."
  echo "If your UTM disk is different (e.g. /dev/nvme0n1), edit hosts/utm-m1/disko.nix or set DISK here."
  exit 1
fi

echo "[1/5] Ensuring git is available..."
nix-shell -p git --run "true"

echo "[2/5] Formatting + mounting with Disko..."
# This will partition, format, and mount to /mnt
nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./hosts/utm-m1/disko.nix

echo "[3/5] Copying flake to /mnt/etc/nixos..."
mkdir -p /mnt/etc
rm -rf /mnt/etc/nixos
cp -a . /mnt/etc/nixos

echo "[4/5] Installing NixOS from flake..."
nixos-install --flake /mnt/etc/nixos#utm-m1 --no-root-password

echo "[5/5] Done. Rebooting..."
reboot
