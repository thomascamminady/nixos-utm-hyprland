{ config, pkgs, ... }:

{
  # UTM/QEMU guest tweaks (Apple Silicon)
  services.qemuGuest.enable = true;

  # Better clipboard + (sometimes) dynamic resolution when using SPICE/QEMU backend
  services.spice-vdagentd.enable = true;

  # Ensure virtio + 9p modules are available early for shared folders and networking
  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "virtio_scsi"
    "virtio_net"
    "9p"
    "9pnet_virtio"
  ];

  boot.kernelModules = [ "9p" "9pnet_virtio" ];

  # A few performance-friendly defaults for VMs
  powerManagement.cpuFreqGovernor = "performance";
}
