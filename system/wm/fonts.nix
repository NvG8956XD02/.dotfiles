{ pkgs, pkgs-unstable, ... }:

{
  # Fonts
  fonts.packages = with pkgs-unstable; [ 
    (nerdfonts.override { fonts = [ # -- Fonts
                                    "Hermit"
                                    "DroidSansMono"
                                    "Ubuntu" "UbuntuMono"
                                    "Iosevka" 
                                    "RobotoMono"
                                    "JetBrainsMono"
                                    # -- Symbols
                                    "NerdFontsSymbolsOnly"
                                  ];
                         })
    powerline
    terminus_font
    font-awesome
    weather-icons
    liberation_ttf
    # Icons & Symbolics
    ## Noto 
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ## Papirus
    papirus-icon-theme
  ];
}
