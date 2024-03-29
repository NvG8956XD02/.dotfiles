{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch
    libnotify
    timer
    killall
    rsync
    hwinfo
    brightnessctl
    unzip
    libsixel 
    imagemagick 
  ];
}
