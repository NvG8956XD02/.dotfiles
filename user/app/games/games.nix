{ pkgs, pkgs-unstable , ... }:

{
  home.packages = with pkgs; [
    # -- Deps -- #
    # Wine
    wine
    wineWayland
    
    # ProtonUp
    protonup
    protonup-qt
  
    # Launchers
    # steam
    lutris 

  ]; 
}
