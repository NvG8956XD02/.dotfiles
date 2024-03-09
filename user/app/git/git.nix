{ config, pkgs, userSettings, ... }:

{
  programs.git = {
    enable = true;
    package = "${pkgs.git}";
    userName = userSettings.gitName;
    userEmail = userSettings.gitEmail;
    signing.key = "1D1CC0C454205F15";
    signing.signByDefault = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
