#!/bin/zsh

#############################################################
#															#
#	Author: Louise Pieri: cpieri@student.42.fr (aka delay)	#
#															#
#############################################################

source colors.sh

clean()
{
	echo "${RED}Clean of the old repo${NONE}"
	rm -rf $PermanatePath
	rm -rf $LaunchAgentsPath/$LabelName
}

setup_dir()
{
	echo "${YELLOW}Move to the folder home${NONE}"
	cd $HOME
	echo "${BLUE}Create .scripts_${LOGNAME} folder in the home${NONE}"
	mkdir $PermanatePath
}

copy_files()
{
	IncludeColor="${PermanatePath}/colors.sh"
	IncludeLib="${PermanatePath}/libsession.sh"

	echo "${CYAN}Copy ${MAGENTA}colors.sh${NONE}${CYAN} file in the permanate folder${NONE}"
	cp $InitialPath/colors.sh $PermanatePath/colors.sh
	echo "${CYAN}Copy ${MAGENTA}libsession.sh${NONE}${CYAN} file in the permanate folder${NONE}"
	cp $InitialPath/libsession.sh $PermanatePath/libsession.sh
	sed -e "s/colors.sh/${IncludeColor//\//\/}/g" -i '.bak' $PermanatePath/libsession.sh
	rm $PermanatePath/libsession.sh.bak
	echo "${CYAN}Copy ${MAGENTA}main.sh${NONE}${CYAN} file in the permanate folder${NONE}"
	cp $InitialPath/main.sh $PermanatePath/main.sh
	sed -e "s/libsession.sh/${IncludeLib//\//\/}/g" -i '.bak' $PermanatePath/main.sh
	rm $PermanatePath/main.sh.bak
	echo "${CYAN}Copy ${MAGENTA}${LabelName}${NONE}${CYAN} file in the LaunchAgents folder${NONE}"
	cp $InitialPath/fr.42.lyon.loginscript.users.plist $LaunchAgentsPath/$LabelName
	chmod -R +x $PermanatePath
}

configure_plist()
{
	echo "${CYAN}Replace MAIN_PATH in ${MAGENTA}${LabelName}${NONE}${CYAN} file${NONE}"
	sed -e "s/MAIN_PATH/${MainPath//\//\/}/g" -i '.bak' $LaunchAgentsPath/$LabelName
	rm $LaunchAgentsPath/$LabelName.bak
	echo "${CYAN}Replace LABEL_NAME in ${MAGENTA}${LabelName}${NONE}${CYAN} file${NONE}"
	sed -e "s/LABEL_NAME/${LabelName}/g" -i '.bak' $LaunchAgentsPath/$LabelName
	rm $LaunchAgentsPath/$LabelName.bak
	echo "${CYAN}Load ${MAGENTA}${LabelName}${NONE}${CYAN} file with launchctl${NONE}"
	launchctl load $LaunchAgentsPath/$LabelName
}

main()
{
	InitialPath=$(pwd)
	PermanatePath="${HOME}/.scripts_${LOGNAME}"
	LaunchAgentsPath="${HOME}/Library/LaunchAgents"
	MainPath="${HOME}/.scripts_${LOGNAME}/main.sh"
	LabelName="fr.42.lyon.loginscript.${LOGNAME}.plist"

	echo "${PINK}### Starting the configuration ###${NONE}"
	clean
	setup_dir
	copy_files
	configure_plist
	echo "${RED}Clean of the configuration repo${NONE}"
	rm -rf $InitialPath
	zsh -i; cd;
	echo "${GREEN}The configuration is complete!${NONE}"
}

main
