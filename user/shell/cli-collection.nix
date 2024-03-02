{ pkgs, ... }:
{
  home.packages = with pkgs; [
    disfetch neofetch lolcat onefetch starfetch
    libnotify
    timer
    killall
    rsync
    hwinfo
    brightnessctl
    unzip
  ];
}
