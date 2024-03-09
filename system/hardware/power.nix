{ config, pkgs, ... }: 

{
  # Better Scheduling for CPU cycles
  services.system76-scheduler.settings.cfsProfiles.enable = true;
  
  # Enable TLP, better than GNOMEs one
  services.tlp = {
    enable = true;
    settings = {
      CPU_SALING_GOVERNOR_ON_AC = "performance";
      CPU_SALING_GOVERNOR_ON_BAT = "powersave";
      
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 80;
    };
  };
  
  # Disable GNOMEs power management
  services.power-profiles-daemon.enable = false;
  
  # Enable PowerTop
  powerManagement.powertop.enable = true;
}
