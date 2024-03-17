{ config, lib, pkgs, userSettings, ...}:

{
  #home.packages = [ pkgs.rofi-wayland ];
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-emoji
      rofi-pulse-select
      rofi-calc
      rofi-file-browser 
    ];
    terminal = "${userSettings.term}";
    location = "center";
    extraConfig = {
      modi = "drun,run";
      sidebar-mode = true;
      sort = false;
      show-icons = true;
      icon-theme = lib.mkForce "Papirus";

      display-drun = "🖥️ Apps: ";
      display-file-browser-extended = "🗄️ Files: ";
      display-window = "🪟 Windows: ";
    };

  };
}
