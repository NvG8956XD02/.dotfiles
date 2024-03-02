{ config, lib,  pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ kanshi ];
  
  systemd.user.services.kanshi = {
    description = "Kanshi output autoconfig";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = ''${pkgs.kanshi}/bin/kanshi'';
      RestartSec = 5;
      Restart = "always";
    };
  };
}
