#!/bin/zsh

#############################################################
#															#
#	Author: Louise Pieri: cpieri@student.42.fr (aka delay)	#
#															#
#############################################################

source colors.sh

######
#	Function configure_dock
#	This function takes 2 arguments
#	@argument OrientationDock 3 options: left, buttom, right !Required
#	@argument AutoHideDock 2 options: 0 (for false), 1 (for true) !Required
#	@argument DockApplications takes array formated like this: ("ApplicatioName1" "ApplicationName2" "ApplicationName3") !Required
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
#	Function configure_screensaver
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
	echo "${GREEN}Configuration of Scroll Direction done${NONE}"
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

######
#	Function configure_menubar()
#	This function takes 0 argument
#	MenuBarIcons takes array formated like this: ("Bluetooth" "Keychain" "Clock") !Required
######
configure_menubar()
{
	echo "\n${PINK}###  show_icons_in_menu_bar function  ###${NONE}";

	for i in "${MenuBarIcons[@]}"; do
		echo "${CYAN}Icon add to the menu bar:${NONE}${MAGENTA} ${i}${NONE}";
		if [ "$i" = "Keychain" ]
		then
			PathMenu="/Applications/Utilities/Keychain Access.app/Contents/Resources/Keychain.menu"
		else
			PathMenu="/System/Library/CoreServices/Menu Extras/${i}.menu"
		fi
		defaults write com.apple.systemuiserver menuExtras -array-add "${PathMenu}"
	done

	echo "${YELLOW}Restart the menu-bar${NONE}"
	killall SystemUIServer
	echo "${GREEN}Configuration of MenuBar done${NONE}"
}

######
#	Function configure_mousespeed()
#	This function takes 1 argument
#	@argument Speed take an int between 1(low) and 10(fast)
#	For now you have to logout/login to changes take effect
######
configure_mousespeed()
{
	Speed=$1

	case $Speed in
		1) Speed=0 ;;
		2) Speed=0.125 ;;
		3) Speed=0.5 ;;
		4) Speed=0.6875 ;;
		5) Speed=0.875 ;;
		6) Speed=1 ;;
		7) Speed=1.5 ;;
		8) Speed=2 ;;
		9) Speed=2.5 ;;
		10) Speed=3 ;;
		*) Speed=1 ;;
	esac

	echo "\n${PINK}###  configure_mousespeed function  ###${NONE}";
	echo "${BLUE}Set your mousespeed $Speed ${NONE}";
	defaults write -g com.apple.mouse.scaling $Speed
	echo "${GREEN}Configuration of MouseSpeed done${NONE}"	
}

#####
#	Function configure_volume()
#	This function takes 2 arguments
#	@argument Output take an int, it represents the percentage of the output volume 
#	@argument Alert take an int, 0 or 1. Disable or enable the alert volume
######
configure_volume()
{
	Output=$1
	Alert=$2

	echo "\n${PINK}###  configure_volume function  ###${NONE}";
	echo "${BLUE}Set your volume to $Output %${NONE}";
	osascript -e "set volume output volume $Output"

	if [ $Alert -eq 0 ]
	then
		echo "${BLUE}Disable alert volume${NONE}";
		#disable alert volume
		defaults write -g com.apple.sound.beep.volume 0
		#disable user interface sound effects
		defaults write -g com.apple.sound.uiaudio.enabled 0
		#disable feedback sound when volume is changed
		defaults write -g com.apple.sound.beep.feedback 0
	fi

	echo "${GREEN}Configuration of Volume done${NONE}"	
}