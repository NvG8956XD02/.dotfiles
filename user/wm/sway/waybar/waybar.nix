{ pkgs, lib, ... }:

{
  
  programs.waybar = {
    enable = true;
    #systemd.enable = true;
    #systemd.target = "graphical-session.target";
    settings = [{
          layer= "top";
          position = "top";
          height = 30;
          output = [
            "eDP-1"
            "HDMI-A-1"
          ];
          modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
          modules-center = [ "clock" ];
          modules-right = [ "memory" "pulseaudo" "battery" ];

          "sway/workspaces" = {
            disable-scroll = false;
            all-outputs = true;
          };
          "clock" = {
            format = "{:%H%M}";
            tooltip-format = "{:%a %Y-%m-%d %l:%M %p}";
          };
          "pulseaudio" = {
            format = "VOL: {volume}%";
            format-bluetooth = "{volume}% {icon}%";
            format-muted = "X";
            on_click = "pavucontrol";
          };
    }];
    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
    '';
  };
}
