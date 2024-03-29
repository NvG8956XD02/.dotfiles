{ pkgs, ... }:
let
  myAliases = {
    emacs = "emacsclient -c -a 'emacs'"; 
  };

in {
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    history.size = 1024;
    enableAutosuggestions = true;
    initExtra = ''
      neofetch-dashboard;
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  }; 
}
