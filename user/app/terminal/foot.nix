{ pkgs , lib, userSettings, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;
    #package = "${pkgs.foot}";
    settings = {
      main = {
        term = "foot";
        #shell = lib.mkForce "$SHELL";
        pad = lib.mkForce "15x15";
      };
      scrollback = {
        lines = lib.mkForce 1000;
        multiplier = lib.mkForce 3.0;
        indicator-position = lib.mkForce "relative";
      };
      mouse = {
        hide-when-typing = lib.mkForce "no";
        alternate-scroll-mode = lib.mkForce "yes";
      };
      environment = {
        name = "value";
      };
      colors = {
        alpha = lib.mkForce 0.9;
      };
    };
  };
}
