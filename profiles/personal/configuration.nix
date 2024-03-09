{ ... }:
{
  imports =
    [ 
      ../default/configuration.nix # Had the default config + for waht need to games and dev
      ../../system/hardware-configuration.nix
      ../../system/hardware/gamepad.nix
      ../../system/app/gamemode.nix
      ../../system/app/steam.nix
      ../../system/security/gpg.nix
      ../../system/security/firewall.nix
    ];

  # Enable and Schedule Garbage Collections
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };
}

