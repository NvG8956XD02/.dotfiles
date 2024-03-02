{ config, lib , pkgs, userSettings, ... }:

{
  
  imports = [
    (./. + "../../../app/terminal"+("/"+userSettings.term)+".nix")
    ./waybar/waybar.nix
  ];
   
  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Ink";
    size = 36;
  };
   
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = rec {
      modifier = "Mod4";
      terminal = userSettings.term;
      bars = [
        { command = "${pkgs.waybar}/bin/waybar";}
      ];
      input = {
        "type:keyboard" = {
          xkb_layout = "hu";
        };
        "type:touchpad" = {
          tap = "enabled";
          click_method = "clickfinger";
          natural_scroll = "enabled";
        };
      };
      keybindings = 
      	let
          modifier = config.wayland.windowManager.sway.config.modifier; 
        in lib.mkOptionDefault {
          "${modifier}+p" = "exec ${pkgs.fuzzel}/bin/fuzzel";
          "${modifier}+Shift+P" = "exec ${pkgs.rofi}/bin/rofi -show combi -combi-modes 'window,run,ssh' -modes combi ";
        };
      startup = [
        # -- Here are goes the startups 
      ];
    };
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_MONREPARENTING=1
    '';
  };
}
