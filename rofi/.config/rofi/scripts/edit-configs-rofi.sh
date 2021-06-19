#!/bin/bash


declare options=("Alacritty
Kitty
Picom
Mutt
Mbsync
Xmonad
Xmobar
Xinitrc
Zshrc
Bash
Rofi-Configs
Quit")

choice=$(echo -e "${options[@]}" | rofi -dmenu -i -p 'Edit config file: ')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	Alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml"
	;;
	Kitty)
		choice="$HOME/.config/kitty/kitty.conf"
	;;
	Picom)
		choice="$HOME/.config/picom/picom.conf"
	;;
	Mutt)
		choice="$HOME/.config/mutt/muttrc"
	;;
	Mbsync)
		choice="$HOME/.mbsyncrc"
	;;
	Xmobar)
		choice="$HOME/.config/xmobar/xmobarrc"
	;;
	Xmonad)
		choice="$HOME/.xmonad/xmonad.hs"
	;;
	Xinitrc)
		choice="$HOME/.xinitrc"
	;;
	Zshrc)
		choice="$HOME/.zshrc"
	;;
	Bash)
		choice="$HOME/.bashrc"
	;;
	Rofi-Configs)
		choice="$HOME/.config/rofi/scripts/edit-configs-rofi.sh"
	;;
	*)
		exit 1
	;;
esac
alacritty -e nvim "$choice"

