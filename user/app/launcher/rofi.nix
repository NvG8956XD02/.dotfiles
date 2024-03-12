{ config, lib, pkgs, userSettings, ...}:

{
  #home.packages = [ pkgs.rofi ];
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-top
      rofi-emoji
      rofi-pulse-select
      rofi-calc
    ];
    terminal = "${userSettings.term}";
    extraConfig = {
      modi = "drun,filebrowser,window,emoji";
      sidebar-mode = true;
      sort = false;
      show-icons = true;
      icon-theme = "Noto Color Emoji";

      display-drun = "Apps: ";
      display-filebrowser = "Files: ";
      display-window = "Windows: ";
    };

  };
}
