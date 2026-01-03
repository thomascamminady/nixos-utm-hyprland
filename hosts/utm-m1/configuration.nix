{ config, pkgs, hostName, ... }:

{
  imports = [
    ./disko.nix
    ../../modules/base.nix
    ../../modules/users.nix
    ../../modules/desktop-hyprland.nix
    ../../modules/utm-optimizations.nix
    ../../modules/utm-sharing.nix
  ];

  networking.hostName = hostName;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.thomas = import ../../home/thomas.nix;

  system.stateVersion = "24.05";
}
