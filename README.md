# Scripts for configure your session @42

Do you find it painful to reset all your preferences every time you change computers?

That's why I created this directory too. In this directory you will find a set of functions to change your preferences on Macos.

## How does it work?

### It's very simple !

Clone this repository and open the `main.sh` file.

In the `main.sh` file, write your `main`.

For exemple:

```sh
source libsession.sh  #include the library

main()
{
	DockApplications=("App1" "App2" "App3") # All the applications I want in my dock
	MenuBarIcons=("Bluetooth" "Keychain") # All the menus I want in my menu bar

	configure_dock bottom 0 # Calling function configure_dock for set my dock in the bottom without the autohide
	configure_wallpaper "\"${HOME}/your/path/picture.jpg\"" # Calling function configure_wallpaper for change my wallpaper
	configure_screensaver 0 0 # Calling function configure_screensaver for require my password on my screensaver without delay
	configure_hotcorners tr 5 # Calling function configure_hotcorners for add one hot corners
	configure_keyrepeat # Calling function configure_keyrepeat set the keyrepeat at the minimum delay
	configure_menubar # Calling function configure_menubar for add in my menu bar all MenuBarIcons
	configure_mousespeed 5 # Calling function configure_mousespeed to set the mousespeed to 5 
	configure_volume 50 0 # Calling function configure_volume to set the ouput volume at 50% and disable alert volume
}

main
```

~~For now you have to execute the script like that `sh main.sh` but soon he will have another script to launch the `main` the start of your session ;)~~

Now just launch the command `sh .configure.sh` ! Logout and Re-Login and it's finish :)

## I want to contribute to the project! But how?
 - Fork this repository
 - Clone your repository forked
 - Contribute
 - Push
 - Create a pull request in this repository
 - Wait the merged !
 - Be happy
