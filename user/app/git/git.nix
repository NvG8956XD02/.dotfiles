{ config, pkgs, userSettings, ... }:

{
  programs.git = {
    enable = true;
    package = "${pkgs.git}";
    userName = userSettings.gitName;
    userEmail = userSettings.gitEmail;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
