{ config, pkgs, pkgs-unstable, systemSettings, userSettings, ... }:

{
  imports = [
    ../default/home.nix  # --> load the defaults
  ];
 
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    ## --=[ Core ]=-- ##
    zsh
    alacritty
    git
    vim
    
    # -- Personal Specific --
    nyxt
    
    # -- Office & Media
    # vlc
    libreoffice
    
    sxiv	# image viewer
    mpv		# video player

    # Games 
    #wine
    #proton
    #protonup-qt
   
  ];

  programs.home-manager.enable = true;
}
