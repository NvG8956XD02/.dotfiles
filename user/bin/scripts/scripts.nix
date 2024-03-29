{ pkgs, ... }:

{
  environment.systemPackages = [
    (import (./. + "/apply-system.nix") { inherit pkgs; })
    (import (./. + "/apply-home.nix") { inherit pkgs; })
    (import (./. + "/neofetch-dashboard/neofetch-dashboard.nix") { inherit pkgs; })
  ];
}
