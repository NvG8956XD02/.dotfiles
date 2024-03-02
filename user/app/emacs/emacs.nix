{ config, lib, pkgs, pkgs-unstable, userSettings, systemSettings, ...}:
let

in {
  home.packages = with pkgs; [
    # Dependencies for Some Emacs Packages
    hunspell
    hunspellDicts.en-us
    hunspellDicts.hu_HU
   ];
  
  programs.emacs = {
    enable = true;
    package = userSettings.emacsPkg;
    extraPackages = epkgs: [
      epkgs.magit
    ];
   
    extraConfig = ''
      (global-visual-line-mode t)
      (global-display-line-numbers-mode 1)
    '';
  }; 
  services.emacs.enable = true; 
}
