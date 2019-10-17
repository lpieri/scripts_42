#!/bin/zsh

######
#	Author: Louise Pieri: cpieri@student.42.fr (aka delay)
######

NONE="\033[0m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
PINK="\033[38;5;206m"

######
#	Function configure_dock()
#	This function takes 2 arguments
#	@argument OrientationDock 3 options: left, buttom, right !Required
#	@argument AutoHideDock 2 options: 0 (for false), 1 (for true) !Required
#	@argument AutoHideDock takes array formated like this: ("ApplicatioName1" "ApplicationName2" "ApplicationName3") !Required
######
configure_dock()
{
	OrientationDock=$1;
	AutoHideDock=$2;

	echo "\n${PINK}###  configure_dock function  ###${NONE}";
	echo "${BLUE}Setup Orientation of dock${NONE}"
	defaults write com.apple.dock orientation $OrientationDock;
	echo "${BLUE}Setup AutoHide of dock${NONE}"
	defaults write com.apple.Dock autohide -int $AutoHideDock;
	echo "${RED}Clean all application save in the dock${NONE}"
	defaults write com.apple.dock persistent-apps "()";
	for i in "${DockApplications[@]}"; do
		echo "${CYAN}Application add to the dock:${NONE}${MAGENTA} ${i}${NONE}";
		defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/${i}.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";
	done
	echo "${YELLOW}Restart the Dock${NONE}"
	killall Dock;
	echo "${GREEN}Configuration of Dock done${NONE}"
}

######
#	Function configure_wallpaper
#	This function takes 1 argument
#	@argument WallpaperPath in format: "\"$HOME/your/path/picture\"" !Required
######
configure_wallpaper()
{
	WallpaperPath=$1;

	echo "\n${PINK}###  configure_wallpaper function  ###${NONE}";
	echo "${BLUE}Set your wallpaper${NONE}";
	osascript -e "tell application \"Finder\" to set desktop picture to POSIX file ${WallpaperPath}";
	echo "${GREEN}Configuration of your wallpaper done${NONE}"
}

######
#	Function configure_wallpaper
#	This function takes 2 arguments
#	@argument PasswordActive 2 options: 0 (for false), 1 (for true) !Required
#	@argument PasswordDelay in seconde !Required
######
configure_screensaver()
{
	PasswordActive=$1;
	PasswordDelay=$2;

	echo "\n${PINK}###  configure_screensaver function  ###${NONE}";
	echo "${BLUE}Set your screen saver setting${NONE}";
	defaults write com.apple.screensaver askForPassword -int $PasswordActive;
	defaults write com.apple.screensaver askForPasswordDelay -int $PasswordDelay;
	echo "${GREEN}Configuration of your screen saver setting done${NONE}"
}

######
#	Function configure_hotcorners
#	configure_hotcorners set only one corner
#	This function takes 2 arguments
#	@argument Corner 4 options: tl (for Top Left Corner), tr (for Top Right Corner), bl (for Buttom Left Corner), br (for Buttom Right Corner) !Required
#	@argument SortCut options: !Required
#		- 5 (for Start Screen Saver)
#		- 6 (for Disable Screen Saver)
#		- 2 (for Mission Control)
#		- 3 (for Application Windows)
#		- 4 (for Desktop)
#		- 7 (for Dashboard)
#		- 12 (for Notification Center)
#		- 11 (for Launchpad)
#		- 10 (for Put Display to Sleep)
#		- 1 (for Nothing)
######
configure_hotcorners()
{
	Corner=$1
	SortCut=$2
	if [ $SortCut -eq 1 ]
	then
		Modifier=1048576
	else
		Modifier=0
	fi

	echo "\n${PINK}###  configure_hotcorners function  ###${NONE}";
	echo "${BLUE}Set your Sortcut ${Corner} Corner setting${NONE}";
	defaults write com.apple.dock "wvous-${Corner}-corner" -int $SortCut;
	defaults write com.apple.dock "wvous-${Corner}-modifier" -int $Modifier;
	echo "${YELLOW}Restart the Dock${NONE}"
	killall Dock;
	echo "${GREEN}Configuration of Hot Corners done${NONE}"
}

######
#	Function configure_scrolldirection
#	This function takes 1 argument
#	@argument Direction 2 options: NO (for false), YES (for true) !Required
######
configure_scrolldirection()
{
	Direction=$1

	echo "\n${PINK}###  configure_scrolldirection function  ###${NONE}";
	echo "${BLUE}Set your scroll direction${NONE}";
	defaults write -g com.apple.swipescrolldirection -bool $Direction
	echo "${GREEN}Configuration of Hot Corners done${NONE}"
}

######
#	Function configure_keyrepeat
#	This function takes 0 argument
#	configure_keyrepeat set at minimum all keyrepeat
######
configure_keyrepeat()
{
	Direction=$1

	echo "\n${PINK}###  configure_keyrepeat function  ###${NONE}";
	echo "${BLUE}Set at minimun value the keyrepeat${NONE}";
	defaults write -g InitialKeyRepeat -int 15
	defaults write -g KeyRepeat -int 2
	echo "${GREEN}Configuration of KeyRepeat done${NONE}"
}

main()
{
	DockApplications=("App1" "App2" "App3")

	configure_dock buttom 0
	configure_wallpaper "\"${HOME}/your/path/picture.jpg\""
	configure_screensaver 0 0
	configure_hotcorners tr 5
	configure_keyrepeat
}

main