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
        "[┌─](bg:#00000000 fg:orange)"
	#"[ ](bg:orange fg:bg)"
        "$os"
        "[](bg:fg fg:orange)"
        # -- Section #DIR -- #
        "$directory"
        "[](bg:green fg:fg)"
        # -- Section #TIME -- #
        "$time"
        "[](bg:selection fg:green)"
        # -- Section #GIT -- # 
        "$git_branch"
	"$git_status"
	"$git_metrics" 
        "[](bg:red fg:selection)"
        # -- Section #PROJECT -- # 
        "$nodejs" "$java$kotlin$gradle" "$rust" "$haskell" "$elixir"
        "[](bg:#0000000 fg:red)"
        # -- Section #END -- #
        "$line_break"
        "[└─](bg:#0000000 fg:orange)"
        "$nix_shell $character"
      ];
      
      # -- Elements -- #
      line_break = {
        disabled = false;
      };
      # Project Types
      nodejs = {
        style = "fg:fg bg:red";
        format = "[ $symbol via [󱜙 $version](bg:red fg:bold fg)]($style)";
        symbol = "󰎙"; 
      };
      java = {
        style = "fg:fg bg:red";
        format = "[ $symbol via [󱐩 $version](bg:red fg:bold fg)]($style)";
        symbol = "";
      };
      kotlin = {
        style = "fg:fg bg:red";
        format = "[ $symbol via [ $version](bg:red fg:bold fg)]($style)";
        symbol = "";
      };
      gradle = {
        style = "fg:fg bg:red";
        format = "[ $symbol via [ $version](bg:red fg:bold fg)]($style)";
        symbol = "";
      };
      rust = {
        style = "fg:fg bg:red";
        format = "[ $symbol via [󰔽 $version](bg:red fg:bold fg)]($style)";
        symbol = "";
      };
      haskell = {
        style = "fg:fg bg:red";
        format = "[ $symbol via [ $version](bg:red fg:bold fg)]($style)";
        symbol = "";
      };
      elixir = {
        style = "fg:fg bg:red";
        format = "[ $symbol via [󰍖 $version](bg:red fg:bold fg)]($style)";
        symbol = "";
      };
      nix_shell = {
        style = "fg:orange";
        disabled = false;
        impure_msg = "[impure]($style)";
	pure_msg = "[pure]($style)";
	unknown_msg = "";
	format = "[\\[nix-shell:[$name](fg:bold orange)\\]]($style)";
      };
      # Directory
      directory = {
        truncation_length = 2;
        truncation_symbol = "../";
        home_symbol = "~";
        style = "bg:fg fg:bg";
        format = "[ 󰝰 $path ]($style)";
      };
      # Time
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:green";
        format = "[[ 󱑍 $time ](bg:green fg:bg)]($style)";
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
      # OS
      os = {
        format = "[$symbol ]($style)";
        style = "bg:orange fg:bg";
        disabled = false;
        symbols = {
          Arch = "󰣇";
          Artix = "";
          Debian = "";
          EndeavourOS = "";
          Fedora = "";
          Gentoo = "";
          Linux = "";
          Manjaro = "";
          Mint = "󰣭";
          NixOS = "";
          Raspbian = "";
          Ubuntu = "";
          Unknown = "";
          Windows = "";
        };
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
