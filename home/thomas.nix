{ config, pkgs, ... }:

{
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    userName = "Thomas Camminady";
    userEmail = "thomas@example.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      eval "$(starship init zsh)"
      alias ll="ls -la"
      alias gs="git status"
    '';
  };

  programs.starship.enable = true;

  home.packages = with pkgs; [
    bat
    eza
    starship
  ];

  # Hyprland config
  xdg.configFile."hypr/hyprland.conf".text = ''
    # Minimal, VM-friendly Hyprland config

    monitor=,preferred,auto,1

    env = XCURSOR_SIZE,24
    env = QT_QPA_PLATFORM,wayland
    env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
    env = GDK_BACKEND,wayland,x11
    env = SDL_VIDEODRIVER,wayland
    env = CLUTTER_BACKEND,wayland

    input {
      kb_layout = us
      follow_mouse = 1
      sensitivity = 0.0
      touchpad {
        natural_scroll = true
      }
    }

    general {
      gaps_in = 4
      gaps_out = 8
      border_size = 2
      allow_tearing = false
      layout = dwindle
    }

    decoration {
      rounding = 8
      blur {
        enabled = true
        size = 6
        passes = 2
      }
    }

    animations {
      enabled = true
    }

    dwindle {
      pseudotile = true
      preserve_split = true
    }

    bind = SUPER, Return, exec, kitty
    bind = SUPER, D, exec, wofi --show drun
    bind = SUPER, Q, killactive
    bind = SUPER, F, fullscreen
    bind = SUPER, E, exec, thunar
    bind = SUPER, Escape, exec, hyprlock

    # Screenshots
    bind = SUPER, S, exec, grim -g "$(slurp)" - | swappy -f -

    # Move focus
    bind = SUPER, H, movefocus, l
    bind = SUPER, L, movefocus, r
    bind = SUPER, K, movefocus, u
    bind = SUPER, J, movefocus, d

    # Workspaces
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5

    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4
    bind = SUPER SHIFT, 5, movetoworkspace, 5

    # Autostart
    exec-once = waybar
    exec-once = dunst
    exec-once = nm-applet --indicator
    exec-once = hyprpaper
  '';

  # Waybar (simple)
  xdg.configFile."waybar/config".text = ''
    {
      "layer": "top",
      "position": "top",
      "height": 28,
      "modules-left": ["hyprland/workspaces"],
      "modules-center": ["clock"],
      "modules-right": ["network", "pulseaudio", "cpu", "memory", "tray"]
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 12px;
    }
    window#waybar {
      background: rgba(20, 20, 20, 0.85);
    }
    #workspaces button {
      padding: 0 8px;
    }
    #clock, #network, #pulseaudio, #cpu, #memory, #tray {
      padding: 0 10px;
    }
  '';

  # Hyprpaper wallpaper (solid color via 1x1 png alternative is overkill; just keep empty)
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload =
    wallpaper = ,
  '';

  # Kitty
  xdg.configFile."kitty/kitty.conf".text = ''
    font_family JetBrainsMono Nerd Font
    font_size 12.0
    enable_audio_bell no
    confirm_os_window_close 0
  '';
}
