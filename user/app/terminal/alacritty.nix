{ pkgs, lib, ...}:

{
  home.packages = [ pkgs.alacritty ];
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    # -- Window
    windows.opacity = lib.mkForce 0.95;
    windows.dimensions = {
      lines = 3;
      columns = 200;
    };
    window.padding = {
      x = 5;
      y = 5;
    };
  };
}
