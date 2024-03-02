{ pkgs , ... }:

{
  imports = [
    ./opengl.nix
  ];
  
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl = {
    driSupport = true;
    extraPackages = with pkgs; [ 
      mesa amdvlk  # amd opengl drivers
      vaapiVdpau   # VaapiVdpau videocoders
      libvdpau 
    ];
    driSupport32Bit = true;
    extraPackages32 = with pkgs; [ 
      driversi686Linux.mesa 
      driversi686Linux.amdvlk
      driversi686Linux.vaapiVdpau
      driversi686Linux.libvdpau-va-gl
     ];
  };
}
