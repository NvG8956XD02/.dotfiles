{ config, pkgs, pkgs-unstable, stylix, systemSettings, userSettings, ... }:

{
  imports = [
    ../default/home.nix  # --> load the defaults
    stylix.homeManagerModules.stylix
    ../../user/style/stylix.nix 
    ../../user/shell/starship.nix
    ../../user/app/games/games.nix
    ../../user/app/discord/discord.nix 
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
    kdenlive 	# Video editor   

    # -- Own Packages -- #
  ];

  programs.home-manager.enable = true;
}
