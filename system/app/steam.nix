{ lib , pkgs , ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steamcmd"
    "steam-original"
    "steam-run"
  ];
  hardware.opengl.driSupport32Bit = true;
  environment.systemPackages = with pkgs; [ steam steamcmd steam-tui ];
  programs.steam = {
    enable = true;
    gamescopeSession.enable = false;
  };
}
