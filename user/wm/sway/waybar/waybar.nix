{ pkgs, lib, stylix, ... }:
let
  icons = {
    power-off = ''&#xf011;'';
    computer = ''&#xf390;'';
    circle = ''&#xf111;'';
    gamepad = ''&#xf11b;'';
    web = ''&#xf0ac;'';
  };
  custom-module-css = ''
    /* iconed */
    #custom-power {
      font-size: 18.25pt;
      font-weight: 900;
      padding: 2px;
    }
  '';
in {
  
  programs.waybar = {
    enable = true;
    #systemd.enable = true;
    #systemd.target = "graphical-session.target";
    settings = [{
          layer= "top";
          position = "top";
          height = 34;
          output = [
            "eDP-1"
            "HDMI-A-1"
          ];
          modules-left = [ "sway/mode" "sway/workspaces" ];
          modules-center = [ "clock" ];
          modules-right = [ "wlr/taskbar" "memory" "battery" "custom/power" ];

          ## -- Modules -- ##
          "sway/mode" = {
            format = "<span>{}</span>";
            tooltip = false;
          };
          "sway/workspaces" = {
            tooltip = false;
            disable-scroll = false;
            all-outputs = false;
            format = "{icon}";
            format-icons = {
              "1" = "${icons.computer}";
              "2" = "${icons.web}";
              "3" = "${icons.gamepad}";
              default = "${icons.circle}";
            };
          };
          "clock" = {
            tooltip = true;
            interval = 10;
            format = ''{:%H:%M}'';
            #format-alt = ''{:%A, %B %d, %Y (%R) }'';
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            "calendar" = {
              mode = "month";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              on-click-right = "mode";
              format = {
                months = "<span color='#FFEAD3'><b>{}</b></span>";
                days = "<span color='#ECC6D9'><b>{}</b></span>";
                weeks = "<span color='#99FFDD'><b>W{}</b></span>";
                weekdays = "<span color='#FFCC66'><b>{}</b></span>";
                today = "<span color='#FF6699'><b><u>{}</u></b></span>";
              };  
            };
            "action" = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };

          "custom/power" = {
            format = ''{icon}'';
            tooltip = false;
            format-icons = {
              default = "${icons.power-off}";
            };
            on-click = "swaynag -t warning -m 'Power Menu Options' -b 'Logout' 'swaymsg exit' -b 'Suspend' 'systemctl suspend' -b 'Shutdown' 'systemctl shutdown' -b 'Reboot' 'systemctl reboot' ";
          };
    }];
    #${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
    style = ''
      * {
        font-family:'Noto Sans', 'Font Awesome 6 Free Solid', sans-serif;
        font-weight: 600;
        font-size: 14.5pt;
        color: #C0CAF5;
      }

      /* main waybar */
      window#waybar {
        background: rgba(31, 21, 25, .98);
      }

      tooltip {
        background: rgba(31, 21, 25, .98);
        border-radius: 5%;
      }

      /* Workspace */
      #workspaces {
        padding-right: 0px;
      }

      #workspaces button {
        padding: 2px;
      }

      #workspaces button.active {
        border-bottom: 3px solid #7AA2F7;
        border-radius: 0;
        margin-top: 3px;
        transition: all .5s ease-in-out;
      }

      #workspaces button.focused {
        color: #A6ADC8;
      }

      #workspaces button.urgent {
        color: #F7768E;
      }
 
      /* Sets background, padding, margins, and borders for (all) modules */
      #workspaces,
      #clock,
      #window,
      #temperature,
      #cpu,
      #memory,
      #wireplumber,
      #tray,
      #battery {
        padding: 0 10px;
        border: 0;
      }

      /* Hide window module when not focused on window or empty workspace */
      window#waybar.empty #window {
        padding : 0px;
        margin: 0px;
        border: 0px;
      }

      window#waybar #window {
        transition: all .5s ease;
      }

      #tray {
        border-radius: 12px;
        margin-right: 4px;
      }

      #window {
        border-radius: 12px;
      }
      
      ${custom-module-css}
    '';
  };
}
