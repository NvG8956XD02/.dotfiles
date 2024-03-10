{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [ starship ];
  
  programs.starship = {
    enable = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      # -- Base -- #
      scan_timeout = 10;
      add_newline = false;
      palette = "def";
     
      format = lib.concatStrings [
	# -- Section #START -- #
        " [](bg:#00000000 fg:yellow)"
	"[ ](bg:yellow fg:bg)"
        "[](bg:comm fg:yellow)"
        # -- Section #1 -- #
        "$directory"
        "[](bg:selection fg:comm)"
        # -- Section #2 -- # 
        "$git_branch"
	"$git_status"
	"$git_metrics" 
        "[](bg:#0000000 fg:selection)"
        # -- Section #END -- #
        "$character"
      ];
      
      # -- Elements -- #
      # Directory
      directory = {
        truncation_length = 2;
        truncation_symbol = "../";
        home_symbol = "~";
        style = "bg:comm fg:fg";
        format = "[ 󰝰 $path ]($style)";
      };
      # EndCharacter
      character = {
        success_symbol = "[ ](bold green) ";
        error_symbol = "[ ](bold red) ";
      };
      # Git - 
      git_branch = {
        format = "[ $symbol$branch(:$remote_branch) ]($style)";
        symbol = " ";
        style = "fg:blue bg:selection";
      };
      git_status = {
        format = "[$all_status]($style)";
        style = "fg:blue bg:selection";
      };
      git_metrics = {
        format = "([+$added]($added_style))[]($added_style)";
        added_style = "fg:purple bg:selection";
        deleted_style = "fg:bright-red bg:235";
        disabled = false;
      };   
 
      # -- Color -- #
      palettes."def" = {
        bg = "#" + config.lib.stylix.colors.base00;
        bgLight = "#" + config.lib.stylix.colors.base01;
        selection = "#" + config.lib.stylix.colors.base02;
        comm = "#" + config.lib.stylix.colors.base03;
        bgDark = "#" + config.lib.stylix.colors.base04;
        fg = "#" + config.lib.stylix.colors.base05;
        fgLight = "#" + config.lib.stylix.colors.base06;
        fgDark = "#" + config.lib.stylix.colors.base07;
        red = "#" + config.lib.stylix.colors.base08;
        orange = "#" + config.lib.stylix.colors.base09;
        yellow = "#" + config.lib.stylix.colors.base0A;
        green = "#" + config.lib.stylix.colors.base0B;
        cyan = "#" + config.lib.stylix.colors.base0C;
        blue = "#" + config.lib.stylix.colors.base0D;
        purple = "#" + config.lib.stylix.colors.base0E;
        brow = "#" + config.lib.stylix.colors.base0F;
      };
    };
      
  };
}
