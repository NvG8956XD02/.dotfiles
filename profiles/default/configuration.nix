{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
  # -- Enable Nix Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
     experimental-features = nix-command flakes
    '';
  };
  
  # Enable and Schedule Garbage Collections
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };

  # -- Import modules
  imports =
    [ 
      ../../system/hardware-configuration.nix
      ../../system/hardware/systemd.nix		# systemd config
      ../../system/hardware/kernel.nix		# kernel config
      ../../system/hardware/ssd.nix		# SSD setting , fstrim
      ../../system/hardware/power.nix		# Power Management ( - For Laptop)
      ../../system/hardware/time.nix		# Network time
      ../../system/hardware/opengl.nix		# enable opengl
      ../../system/hardware/vdriver.nix		# Video driver - amdgpu - mesa
      ../../system/hardware/cpu.nix		# CPU driver
      ../../system/hardware/printing.nix	# enable printing
      ../../system/hardware/bluetooth.nix	# enable bluetooth
      (./. + "../../../system/wm"+("/"+userSettings.wm)+".nix") # Window Manager
      ../../system/app/docker.nix		# Docker
      ../../system/security/gpg.nix		# Gnu key
      ../../system/security/firewall.nix	# Basic Firewall
      ../../system/security/automount.nix	# Mounting
      ../../system/security/ssh.nix		# OpenSSH 
      
      ../../system/style/stylix.nix		# Stylix

      ../../user/bin/scripts/scripts.nix	# Own Commands
    ];
 
  # -- Kernel modules
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" "cpureq_powersave" ];
  boot.kernelParams = [ "quiet" ];
  boot.supportedFilesystems = [ "btrfs" ];
  
  # -- Bootloader
  boot.loader = {
    systemd-boot.enable = if (systemSettings.bootMode == "uefi") then true else false;
    efi = {
      canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
      efiSysMountPoint = systemSettings.bootMountPath;
    };   
    grub = {
      devices = systemSettings.grubDevice;
      enable = if (systemSettings.bootMode == "uefi") then false else true;
      efiSupport = true;      
      useOSProber = true;
    };
  };
  #boot.plymouth.enable = true;
  #boot.plymouth.theme = "breeze";  
 
  # -- Networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;

  # -- Timezone & locale
  time.timeZone = systemSettings.timezone;
  i18n = {
    defaultLocale = systemSettings.locale;
    extraLocaleSettings = {
      LC_ADDRESS = systemSettings.locale;
      LC_IDENTIFICATION = systemSettings.locale;
      LC_MEASUREMENT = systemSettings.locale;
      LC_MONETARY = systemSettings.locale;
      LC_NAME = systemSettings.locale;
      LC_NUMERIC = systemSettings.locale;
      LC_PAPER = systemSettings.locale;
      LC_TELEPHONE = systemSettings.locale;
      LC_TIME = systemSettings.locale;
    };
  };
  
  # -- User Account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "wheel" "networkmanager" "sway" "audio" ];
    packages = [];
    uid = 1000;
  };

  # -- Set ZSH shell as Default
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;  
  
  # -- Font 
  fonts.fontDir.enable = true;
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "hu";
  };  

  # -- XDG
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  # -- Default Packages
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    zsh
    git
    git-crypt
    home-manager
  ];
  
  security.polkit.enable = true; 
  system.stateVersion = "23.11"; # Did you read the comment?
}

