{ pkgs, pkgs-unstable, ... }:

{  
  hardware.xpadneo = {
    enable = true;
    package = "${pkgs-unstable.xpadneo}";
  };
  
  hardware.xone = {
    enable = true;
    package = "${pkgs-unstable.xpadneo}";
  };
}
