{ pkgs, ... }:
let
  myAliases = {
  
  };

in {
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    history.size = 1024;
    enableAutosuggestions = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  home.packages = with pkgs; [
  
  ];
}
