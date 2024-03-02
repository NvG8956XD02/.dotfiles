{ lib,  ... }:

{  
  # Allow Unfree 
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "xow_dongle-firmware"
    "steam-original"
  ];
  
  # Wireless XBox Controller 
  hardware.xpadneo = {
    enable = true;
  };
  
  hardware.xone = {
    enable = true;
  };
}
