{
  description = "Ruins of Myrtre - First Nix flake";

  inputs = {
    # -- NixPkgs -- #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
 
    # -- Home Manager -- #
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # -- Stylix -- #
    stylix.url = "github:danth/stylix";
   
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, stylix ,... }@inputs:
    let
      # ----- [ System Settings ] ----- #
      systemSettings = {
        system = "x86_64-linux";
        hostname = "ruins";
        profile = "personal";
        timezone = "Europe/Budapest";
        locale = "en_US.UTF-8";
      };
      # ----- [ User Settings ] ----- #
      userSettings = rec {
        username = "davy";
        name = "Davy";
        email = "";
        dotFiles = "~/.dotfiles";
        theme = "";
        wm = "sway";
        wmType = "wayland";     		# Now just can be wayland, because
        browser = "firefox";
        defaultRoamDir = "";
        term = "foot";
        font = "Hermit";
        fontPkgs = pkgs.hermit;
        editor = "emacs";
        emacsPkg = pkgs.emacs;
        gitName = "NvG8956XD02";
        gitEmail = "gutenburg429@gmail.com";
      };
      nixpkgs-patched = (import nixpkgs { system = systemSettings.system;} ).applyPatches {
        name = "nixpkgs-patched";
        src = nixpkgs;
      };
      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = { AllowUnfree = false;};
      };
      pkgs-unstable = import nixpkgs-patched {
        system = systemSettings.system;
        config = { AllowUnfree = true;
                   allowUnfreePredicate = ( _ : true);};
      };
      #pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      #pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.system};
    in { 
      # -- NixOS Flake -- #
      nixosConfigurations = {
        ruins = nixpkgs.lib.nixosSystem {
          system = systemSettings.system;
          modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix") ];
          specialArgs = {
            inherit pkgs-unstable;
            inherit systemSettings;
            inherit userSettings;
            inherit (inputs) stylix;
          };
        };
      };
      # -- Home Manager -- #
      homeConfigurations = {
        davy = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix") ];
          extraSpecialArgs = {
            inherit pkgs-unstable;
            inherit systemSettings;
            inherit userSettings;
            inherit (inputs) stylix;
            inherit (inputs) firefox-addons;
          };
        };
      };
    };
}
