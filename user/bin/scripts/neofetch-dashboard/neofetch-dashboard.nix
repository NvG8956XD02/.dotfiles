{ pkgs }:

pkgs.writeShellScriptBin "neofetch-dashboard" ''
  neofetch --config ~/.dotfiles/user/bin/scripts/neofetch-dashboard/config.conf
''
