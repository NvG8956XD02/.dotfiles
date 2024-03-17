{ lib, pkgs, pkgs-unstable , ... }:

{

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam" "steam-original" "steami-run" 
    "lutris"
  ];

  home.packages = with pkgs; [
    # -- Deps -- #
    # Wine
    wine
    wineWayland
    
    # ProtonUp
    protonup
    protonup-qt
  
    # Launchers
    lutris
  ]; 
}
