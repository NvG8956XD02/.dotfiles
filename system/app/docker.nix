{ lib, userSettings, storageDriver ? null, ... }: 

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = "btrfs";
    autoPrune.enable = true;
  };
  users.users.${userSettings.username}.extraGroups = [ "docker" ];
}
