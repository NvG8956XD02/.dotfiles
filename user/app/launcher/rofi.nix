{ config, lib, pkgs, userSettings, ...}:

{

  home.packages = [ pkgs.rofi ]
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-calc
    ];
    font = "Roboto 14";
    terminal = "${usersettings.term}";
    extraConfig = {
      modi = "drun,emoji,ssh";
    };
    theme = 
    let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background-color = mkLiteral "#131313";
        foreground-color = mkLiteral "rgba (247, 251, 252, 100%)";
        border-color = mkLiteral "#F5F5F5";
        width = 512;
      };
    };
    
  };
}
