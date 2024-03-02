{ pkgs, ... }:

{
  imports = [ ./pipewire.nix
              ./dbus.nix
              ./gnome-keyring.nix
              ./kanshi.nix
              ./fonts.nix
            ];

  environment.systemPackages = with pkgs; [ wayland
                                            wlroots
                                          ];
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  services.xserver = {
    enable = true;
    layout = "hu";
    xkbVariant = "";
    xkbOptions = "";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
