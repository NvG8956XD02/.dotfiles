{ lib, pkgs, pkgs-unstable, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
  ];
  home.packages = with pkgs-unstable; [
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
  ];
}
