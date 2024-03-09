{ lib, pkgs, stylix, userSettings, ... }:
let
  themePath = "../../../themes"+("/"+userSettings.theme+"/"+userSettings.theme)+".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/polarity.txt"));
  background = ./. + "../../../themes/default.webp";
in {
  imports = [ stylix.nixosModules.stylix ];
  stylix = {
    autoEnable = false;
    polarity = themePolarity;
    image = background;
    base16Scheme = ./. + themePath;

    targets.console.enable = true;
  };
}
