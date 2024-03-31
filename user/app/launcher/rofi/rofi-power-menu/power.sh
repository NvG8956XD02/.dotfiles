#! /bin/sh
# Define the power options
options=("󰒲 Suspend" "󰍃 Log Out" "⭮ Restart" "⏻ Shutdown")
selected_option=$(echo -e "${options[@]}" | rofi -dmenu -i -p "Power menu: ")
case $selected_option in
	"Power Off") poweroff;;
	"Suspend") 
		swaymsg -t get_outputs | jq '.[] | select(.focused) | .name' | xargs -I % swaymsg "[con_id=%]" swaymsg mark % as_marked
    		swaymsg '[con_mark="as_marked"]' mark --unmark
    		systemctl suspend
		;;
	"Logout") swaymsg exit;;
	"Restart") reboot;;
	*) exit 1;;
esac
