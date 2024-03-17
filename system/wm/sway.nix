{ config, lib, pkgs, ... }:

{ 
  # Import Wayland config
  imports = [ ./wayland.nix
              ./pipewire.nix
              ./dbus.nix
              # import Kanshi for SystemD
              ./kanshi.nix
            ];
  
  # Security
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
    pam.services.login.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;
  
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      #swaylock 
      swaylock-effects swayidle
      waybar
      wl-clipboard
      wf-recorder
      grim
      slurp
      mako

      # -- SystemD Service -- #
      kanshi
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  }; 
  # -- Waybar && SWWW  -- # 
  environment.systemPackages = [
    (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
  ];

  systemd.user.targets.sway-session = {
    description = "Sway Compositor Session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ]; 
    wants = [ "graphical-session-pre.target" ]; 
    after = [ "graphical-session-pre.target" ]; 
  };  

  systemd.user.services.sway = {
    description = "Sway - Wayland Tilling window Manager";
    documentation = [ "man:sway(5)" ];
    bindsTo = [ "graphical-session.target" ]; 
    wants = [ "graphical-session-pre.target" ]; 
    after = [ "graphical-session-pre.target" ]; 
    environment.PATH = lib.mkForce null;
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
      '';
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
