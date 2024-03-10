{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [ swaylock-effects swayidle ];
  ## SwayIdle
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
      { event = "lock"; command = "lock"; }
    ];
    timeouts = [
      { timeout = 300; command = ''${pkgs.swaylock-effects}/bin/swaylock -f''; }
      { timeout = 360; command = ''swaymsg "output * dpms off" resume swaymsg "output * dpms off" ''; }
    ];
  };
  
  ## Swaylock
  programs.swaylock = {
    enable = true;
    package = "${pkgs.swaylock-effects}";
    settings = {
      indicator = lib.mkDefault true;
      
      grace = lib.mkDefault 2;
      fade-in = lib.mkDefault 0.5;
      font = lib.mkDefault "Noto Sans";
      ignore-empty-password = lib.mkDefault true;
      clock = lib.mkDefault true;
      effect-blur = lib.mkDefault "7x5";
      effect-vignette = lib.mkDefault "0.5:0.5";
      # image = "${(./. + "/lockscreen.jpg")}";
    };
  };   
}
