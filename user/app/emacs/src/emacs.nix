{ config, lib, pkgs, pkgs-unstable, userSettings, systemSettings, ...}:
let

in {
  home.packages = with pkgs-unstable; [
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
    '';
  }; 
  services.emacs.enable = true; 
}
