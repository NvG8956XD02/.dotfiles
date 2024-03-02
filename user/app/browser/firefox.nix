{ pkgs, lib, userSettings, firefox-addons, ... }:
let 
    lock-false = {
      Value = false;
      Status = "locked";
    };
 
    lock-true = {
      Value = true;
      Status = "locked";
    };

in {


  #home.packages = with pkgs; [ firefox ];
  
  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };
  
  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  programs.firefox = {
    enable = true;
    #languagePacks = [ "en-US" "hu" ];
    /* --- Policies --- */
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "newtab";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";
    };
    #preferences = {
      #"browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
      #"extensions.pocket.enabled" = lock-false;
      #"extensions.screenshots.disabled" = lock-true;
      #"browser.topsites.contile.enabled" = lock-false;
      #"browser.formfill.enable" = lock-false;
      #"browser.search.suggest.enabled" = lock-false;
      #"browser.search.suggest.enabled.private" = lock-false;
      #"browser.urlbar.suggest.searches" = lock-false;
    #};
    # -- Customize Firefox Settings from Nix for Profile , mentally -- #
    profiles."${ userSettings.username }" = {
      isDefault = true;
      # Set bookmarks
      bookmarks = {

      };
      # Firefox settings
      settings = {
      
      };
      # Firefox CSS styling
      userChrome = ''

      '';
      # Firefox Extensions
      extensions =  [
        firefox-addons.packages."x86_64-linux".ublock-origin
        firefox-addons.packages."x86_64-linux".darkreader
        firefox-addons.packages."x86_64-linux".bitwarden 
        firefox-addons.packages."x86_64-linux".decentraleyes
        firefox-addons.packages."x86_64-linux".cookie-autodelete
        #firefox-addons.packages."x86_64-linux".enhancer-for-youtube
        firefox-addons.packages."x86_64-linux".return-youtube-dislikes
        firefox-addons.packages."x86_64-linux".auto-tab-discard
      ];
      # Search engines 
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definiedAliases = [ "@np" ];
        };
      };
      search.force = true;

    };
  };
}
