{ pkgs }:

pkgs.writeShellScriptBin "apply-home" ''
  pushd ~/.dotfiles
  home-manager switch --flake .
  popd
 ''
