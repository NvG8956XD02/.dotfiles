{pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [ fuzzel ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${userSettings.term}";
        layer = "overlay";
      };
      colors.background = "131313FF";
    };
  };
}
