{ lib , pkgs , pkgs-unstable, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-small"
    "steam-original"
    "steam-run"
  ];
  hardware.opengl.driSupport32Bit = true;
  environment.systemPackages = with pkgs-unstable; [ 
    steam-small 
  ];
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = false;
    package = pkgs-unstable.steam.override {
        extraLibraries = (pkgs: with pkgs; [ openssl curl keyutils ]);
      };
  };
}
