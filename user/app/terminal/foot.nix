{ pkgs , lib, userSettings, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;
    #package = "${pkgs.foot}";
    settings = {
      main = {
        term = "foot";
      };
      colors = {
        alpha = lib.mkForce 0.9;
      };
    };
  };
}
