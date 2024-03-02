{ pkgs, ...}:

{
  # Feral Gamemode #
  environment.systemPackages = [ pkgs.gamemode ];
  programs.gamemode.enable = true;
}
