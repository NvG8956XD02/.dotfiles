{ pkgs , userSettings, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;
    #package = "${pkgs.foot}";
    settings = {
      main = {
        term = "foot";
        font = "${userSettings.font}:size=11";
        box-drawings-uses-font-glyphs = "no";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
