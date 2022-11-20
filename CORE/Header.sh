Color_Off=$(	printf '\033[0m')
RED=$(			printf '\033[00;31m')
GREEN=$(			printf '\033[00;32m')
YELLOW=$(		printf '\033[00;33m')
BLUE=$(			printf '\033[00;34m')
MAGENTA=$(		printf '\033[00;35m')
PURPLE=$(		printf '\033[00;35m')
LRED=$( 			printf '\033[01;31m')
LGREEN=$(		printf '\033[01;32m')
LYELLOW=$(		printf '\033[01;33m')
LBLUE=$(			printf '\033[01;34m')
LPURPLE=$(		printf '\033[01;35m')
DARKGRAY=$(		printf '\033[01;30m')
GRAY=$(			printf '\033[1;37m')
LGRAY=$(			printf '\033[0;37m')

if [ $(id -u) != "0" ]; then
	echo "$LRED[✖] You must be root to do that! [✖]$Color_Off" ; exit ;
fi  

clear

Header () {
echo "$GRAY _________________________________________________________________________________
|                                                                                 |
|                                                                                 |
|$YELLOW   ____                        ____                      _ _                     $GRAY|
|$YELLOW  / ___| _   _ _ __   ___ _ __|  _ \ ___ _ __   ___  ___(_| |_ ___  _ __ _   _   $GRAY|
|$YELLOW  \___ \| | | | '_ \ / _ | '__| |_) / _ | '_ \ / _ \/ __| | __/ _ \| '__| | | |  $GRAY|
|$YELLOW   ___) | |_| | |_) |  __| |  |  _ |  __| |_) | (_) \__ | | || (_) | |  | |_| |  $GRAY|
|$YELLOW  |____/ \__,_| .__/ \___|_|  |_| \_\___| .__/ \___/|___|_|\__\___/|_|   \__, |  $GRAY|
|$YELLOW              |_|                       |_|                              |___/   $GRAY|
|$BLUE                  Author: @MrM8BRH                                               $GRAY|
|                                                                                 |
|_________________________________________________________________________________|
$Color_Off"
}