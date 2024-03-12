{ pkgs, systemSettings, ...}:
let
  cpu = systemSettings.cpu;
in {
  #environment.systemPackages = with pkgs; [ "microcode${cpu}" ];
  hardware.cpu.${cpu} = {
    updateMicrocode = true;
  }; 
}
