{ config, pkgs, userSettings, ... }:

{
  imports = [
    (./. + "../../../user/wm"+("/"+userSettings.wm+"/"+userSettings.wm)+".nix")
    ../../user/shell/sh.nix
    ../../user/shell/cli-collection.nix 
    ../../user/app/git/git.nix
    ../../user/app/launcher/rofi.nix
    ../../user/app/filemanager/yazi.nix
    (./. + "../../../user/app/browser/"+("/"+userSettings.browser)+".nix")
  ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;
  
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [
    # Core
    zsh
    alacritty
    git
    vim
    
    ## fetch
    neofetch
    pfetch
  ];
  
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };
    
  home.stateVersion = "23.11";
}
