{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    neovim
    curl
    wget
    htop
    btop
    tree
    ripgrep
    fd
    jq
    unzip
  ];

  # Sound / screen sharing / portals
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = false;
  };
  security.rtkit.enable = true;

  security.polkit.enable = true;
  services.dbus.enable = true;

  # Useful defaults
  programs.zsh.enable = true;
}
