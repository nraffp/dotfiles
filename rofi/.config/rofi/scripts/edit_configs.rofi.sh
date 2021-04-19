#!/bin/bash


declare options=("Alacritty
XMONAD
XMOBAR
Quit")

choice=$(echo -e "${options[@]}" | rofi -dmenu -p 'Edit config file: ')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	Alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml"
	;;
	XMOBAR)
		choice="$HOME/.config/xmobar/xmobarrc"
	;;
	XMONAD)
		choice="$HOME/.xmonad/xmonad.hs"
	;;
	*)
		exit 1
	;;
esac
alacritty -e nvim "$choice"

