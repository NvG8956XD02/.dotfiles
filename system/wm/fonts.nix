{ pkgs, pkgs-unstable, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [ 
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
    hermit
    # Icons & Symbolics
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
}
