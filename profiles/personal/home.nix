{ config, pkgs, pkgs-unstable, stylix, systemSettings, userSettings, ... }:

{
  imports = [
    ../default/home.nix  # --> load the defaults
    stylix.homeManagerModules.stylix
    ../../user/style/stylix.nix 
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
    gimp	# Image Manipulator

  ];

  programs.home-manager.enable = true;
}