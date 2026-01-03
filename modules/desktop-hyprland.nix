{ config, pkgs, ... }:

{
  # Hyprland + XWayland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Allow Wayland apps to pick correct backends
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
  };

  # TUI login that starts Hyprland
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Needed by many desktop apps
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
  ];

  environment.systemPackages = with pkgs; [
    # Basics
    kitty
    wofi
    waybar
    hyprpaper
    hyprlock
    hypridle
    dunst
    networkmanagerapplet
    pavucontrol
    brightnessctl

    # File manager
    thunar
    thunar-archive-plugin
    xarchiver

    # Screenshots
    grim
    slurp
    swappy

    # Clipboard
    wl-clipboard

    # Utilities
    xdg-utils
    polkit_gnome
  ];

  # Autostart polkit agent for GUI auth prompts
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome authentication agent";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
  };
}
