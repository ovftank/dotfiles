#!/bin/sh
 #_        _     _     _              _
#| |_ __ _| |__ (_)___| |_ __ _ _ __ | | __
#| __/ _` | '_ \| |_  | __/ _` | '_ \| |/ /
#| || (_| | |_) | |/ /| || (_| | | | |   <
 #\__\__, |_.__/|_/___|\__\__,_|_| |_|_|\_\
    #|___/

	sudo chmod --help > /dev/null
	echo "Greetings, $(/usr/bin/users)"
	echo "Pls wait...."
	sleep .5
	source ./function.sh
	osCheck
	packageIstall
	finish
	clear
	cat ~/dotfiles/tgbiztank.png
	rm -rf ~/dotfiles > /dev/null
	exit
