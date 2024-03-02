{ pkgs }:

pkgs.writeShellScriptBin "apply-system" ''
  pushd ~/.dotfiles
  sudo nixos-rebuild switch --flake .
  popd
''
