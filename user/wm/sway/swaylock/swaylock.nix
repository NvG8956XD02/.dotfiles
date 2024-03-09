{ pkgs, ... }:

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
      { timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
      { timeout = 350; command = ''swaymsg "output * dpms off" resume swaymsg "output * dpms off" ''; }
    ];
  };
  
  ## Swaylock
  programs.swaylock = {
    enable = true;
    package = "${pkgs.swaylock-effects}";
    settings = {
      indicator = true;
      indicator-idle-visible = false;
      indicator-radius = 150;
      indicator-thickness = 15;
      indicator-caps-lock = true;

      inside-color = "009DDC88";
      inside-clear-color = "FFD20488";
      inside-caps-lock-color = "009DDC88"; 
      inside-ver-color = "D9D8D888";
      inside-wrong-color = "EE2E2488";      

      ring-color = "890051FF";
      ring-clear-color = "231F20D9";
      ring-caps-lock-color = "231F20D9";
      ring-ver-color = "231F20D9";
      ring-wrong-color = "231F20D9";  
 
      line-color = "009DDC00";
      line-clear-color = "FFD204FF";
      line-caps-lock-color = "009DDCFF";
      line-ver-color = "D9D8D8FF";
      line-wrong-color = "EE2E24FF";

      text-color = "009DDCFF";
      text-clear-color = "DFFD204FF";
      text-caps-lock-color = "009DDC00";
      text-ver-color = "D9D8D8FF";
      text-wrong-color = "EE2E24FF";

      key-hl-color= "009DDCFF";
      bs-hl-color = "EE2E24FF";
      caps-lock-key-hl-color = "FFD204FF";
      caps-lock-bs-hl-color = "EE2E24FF";
      separator-color = "231F2000";

      grace = 2;
      fade-in = 0.5;
      font = "Noto Sans";
      ignore-empty-password = true;
      clock = true;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      image = "${(./. + "/lockscreen.jpg")}";
    };
  };   
}
