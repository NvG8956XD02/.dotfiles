{ config, lib, pkgs, userSettings, ... }:
let
  themePath = "../../../themes"+("/"+userSettings.theme+"/"+userSettings.theme)+".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/polarity.txt"));
  backgroundPath = (./. + "../../../themes"+("/"+userSettings.theme));
  background = (if lib.pathIsRegularFile (backgroundPath+"/background.gif") 
		then (backgroundPath)+"/background.gif" 
		else (if lib.pathIsRegularFile ((backgroundPath)+"/background.webp") 
			then (backgroundPath)+"/background.webp"
			else (./. + "../../../themes")+"/default.webp"));
in {
  home.file.".currentTheme".text = userSettings.theme;
  stylix =  {
    autoEnable = false;
    polarity = themePolarity;
    image = background;
    base16Scheme = ./. + themePath;
    
    fonts = {
      monospace = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      serif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      sansSerif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
      sizes = {
        terminal = 18;
        applications = 12;
        popups = 12;
        desktop = 12;
      };
    };

    ## Targets - Where use the theme    
    targets = {
      foot.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      emacs.enable = true;
      firefox.enable = true;
 
      rofi.enable = true;
      sway.enable = true;
      swaylock.enable = true;
      # swaylock.useImage = true;
      # mako.enable = true;
      waybar.enable = true;
      
      sxiv.enable = true;
    };
  };  
  
  home.packages = with pkgs; [ swww ];
  home.file.".background-stylix" = {
    text = ''
      swww img ''+config.stylix.image+'';
    '';
    executable = true;
  };
}
