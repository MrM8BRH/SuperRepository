#!/bin/bash

Color_Off=$(	printf '\033[0m')
RED=$(			printf '\033[00;31m')
GREEN=$(		printf '\033[00;32m')
YELLOW=$(		printf '\033[00;33m')
BLUE=$(			printf '\033[00;34m')
MAGENTA=$(		printf '\033[00;35m')
PURPLE=$(		printf '\033[00;35m')
LRED=$( 		printf '\033[01;31m')
LGREEN=$(		printf '\033[01;32m')
LYELLOW=$(		printf '\033[01;33m')
LBLUE=$(		printf '\033[01;34m')
LPURPLE=$(		printf '\033[01;35m')
DARKGRAY=$(		printf '\033[01;30m')
LGRAY=$(		printf '\033[0;37m')

if [ $(id -u) != "0" ]; then
	echo "$LRED[✖] You must be root to do that! [✖]$Color_Off"
	exit
fi  

reset

user=`whoami`
distribution=`awk '{print $1}' /etc/issue`
year=`date +"%Y"`

Header () {
echo \
"$LGRAY ============================================================
$LGRAY |$LYELLOW		        SuperRepository		 $LGRAY	    |
$LGRAY |$LYELLOW			 ____  ____  			 $LGRAY   |
$LGRAY |$LYELLOW			/ ___||  _ \ 			 $LGRAY   |
$LGRAY |$LYELLOW			\___ \| |_) |			 $LGRAY   |
$LGRAY |$LYELLOW			 ___) |  _ < 			 $LGRAY   |
$LGRAY |$LYELLOW			|____/|_| \_\			 $LGRAY   |
$LGRAY |							 $LGRAY   |
$LGRAY |$LGREEN	 $distribution|$LRED$user|$LPURPLE$year	 			   $LGRAY |
$LGRAY |							 $LGRAY   |
$LGRAY |$BLUE	 Author:$YELLOW Ismael Jabr 🕴				 $LGRAY   |
$LGRAY |$BLUE	 Email:$YELLOW mrm8brh@protonmail.ch   	 	 $LGRAY   |
$LGRAY |$BLUE	 Version:$YELLOW 1.0					   $LGRAY |
$LGRAY ============================================================$Color_Off";
}

Repo_list () {
echo -e "\n$LGRAY (Requirements before adding Repositories ==$LRED [wget] & [curl] & [apt-transport-https] & [dpkg]$DARKGRAY)\n"
echo -e "$LYELLOW [+] Select the Repository: $LYELLOW\n
		[0] Wine
		[1] Signal
		[2] Sublime
		[3] Brave Browser
		[4] Opera Browser
		[5] Yandex browser
		[6] Visual Studio Code\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0)	cd /tmp/ ; sleep 1.4;
	sudo dpkg --add-architecture i386 ; sleep 1.4;
	wget -nc https://dl.winehq.org/wine-builds/winehq.key; sudo apt-key add winehq.key ; sleep 1.4;
	sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' ; sleep 1.4;
	yes "" | sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport ; sleep 1.4;
	cd -; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;
	
1)	curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add - ; sleep 1.4;
	echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

2)	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - ; sleep 1.4;
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

3)	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - ;sleep 1.4;
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list ; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

4)	wget -qO- https://deb.opera.com/archive.key | sudo apt-key add - ; sleep 1.4;
	sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free" ; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

5)	wget -qO-  https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | sudo apt-key add - ; sleep 1.4;
	echo "deb [arch=amd64] http://repo.yandex.ru/yandex-browser/deb beta main" > /etc/apt/sources.list.d/yandex-browser-beta.list ; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

6)	cd /tmp/ ; sleep 1.4;
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg ; sleep 1.4;
	sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ ; sleep 1.4;
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' ; sleep 1.4;
	cd -; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

back) clear ; Header ; main_menu ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Repo_list ;;
esac
}

Install_list () {
echo "$LYELLOW [+] Select the category:"
echo -e "$LRED**Be sure to update repositories (APT, Snap, Pip) before installing tools or packages (as needed)**\n$LYELLOW
		[0] Apt Packages
		[1] Snap Packages
		[2] Pip Packages\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) clear ; Header ; Apt_list;;
1) clear ; Header ; Snap_list;;
2) clear ; Header ; Pip_list;;

back) clear ; Header ; main_menu ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Install_list ;;
esac
}

Apt_list () {
echo "$LYELLOW [+] Select the package:"
echo -e "$LYELLOW
		[0] Primary
		[1] Programming Languages
		[2] Browsers
		[3] Security Tools
		[4] Editors Text & IDE
		[5] Multimedia
		[6] Extras\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) clear ; Header ; Primary_list ;;
1) clear ; Header ; Prog_lan_list ;;
2) clear ; Header ; Brows_list ;;
3) clear ; Header ; Sec_tools ;;
4) clear ; Header ; edit_ide_list;;
5) clear ; Header ; Multi_med_list;;
6) clear ; Header ; Extras;;

back) clear ; Header ; Install_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Apt_list ;;
esac
}

Primary_list () {
echo "$LRED [+] Select the package: "
echo -e "$LYELLOW
		[0]  All Packages
		[1]  git
		[2]  wget
		[3]  curl
		[4]  snap
		[5]  gufw
		[6]  htop
		[7]  dpkg
		[8]  net-tools
		[9]  python3-pip
		[10] build-essential
		[11] apt-transport-https
		[12] rar + unrar + engrampa\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in
0) apt install -y git wget curl snap gufw htop dpkg net-tools python3-pip build-essential apt-transport-https rar unrar engrampa ; sleep 1.4 ; clear ; Header ; Apt_list ;;
1) apt install -y git ; sleep 1.4 ; clear ;Header ; Primary_list ;;
2) apt install -y wget ; sleep 1.4 ; clear ; Header ; Primary_list ;;
3) apt install -y curl ; sleep 1.4 ; clear ; Header ; Primary_list ;;
4) apt install -y snap ; sleep 1.4 ; clear ; Header ; Primary_list ;;
5) apt install -y gufw ; sleep 1.4 ; clear ; Header ; Primary_list ;;
6) apt install -y htop ; sleep 1.4 ; clear ; Header ; Primary_list ;;
7) apt install -y dpkg ; sleep 1.4 ; clear ; Header ; Primary_list ;;
8) apt install -y net-tools ; sleep 1.4 ; clear ; Header ; Primary_list ;;
9) apt install -y python3-pip ; sleep 1.4 ; clear ; Header ; Primary_list ;;
10) apt install -y build-essential ; sleep 1.4 ; clear ; Header ; Primary_list ;;
11) apt install -y apt-transport-https; sleep 1.4 ; clear ; Header ; Primary_list ;;
12) apt install -y rar unrar engrampa; sleep 1.4 ; clear ; Header ; Primary_list ;;
back) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Primary_list ;;
esac
}

Prog_lan_list () {
echo "$LRED [+] Select the package: "
echo -e "$LYELLOW
		[0] C++
		[1] npm
		[2] nodejs
		[3] Java 8
		[4] Java 11
		[5] MySql
		[6] PHP
		[7] Python
		[8] Postgresql
		------
		[9] WineHQ		(need to add repository)\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) apt install -y g++ ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;
1) apt install -y npm ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;
2) apt install -y nodejs ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;
3) apt install -y openjdk-8-jre openjdk-8-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
4) apt install -y openjdk-11-jre openjdk-11-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
5) apt install -y mysql-server mysql-client ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
6) apt install -y apache2 php php-mbstring php-gettext libapache2-mod-php phpmyadmin ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
7) apt install -y python python3.6 python3.8 python3-tk python3.6-tk python3-pil python3-pil.imagetk tesseract-ocr ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
8) apt install -y postgresql ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
9) apt install --install-recommends winehq-stable ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
back) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Prog_lan_list ;;
esac
}

Brows_list () {
echo "$LRED [+] Select the package: " 
echo -e "$LYELLOW
		[0] Brave 	(need to add Repository)
		[1] Opera	(need to add Repository)
		[2] Yandex	(need to add Repository)
 		[3] Firefox
		[4] Chromium\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) apt install -y brave-browser ; sleep 1.4 ; clear ;Header ; Brows_list ;;
1) apt install -y opera-stable ; sleep 1.4 ; clear ;Header ; Brows_list ;;
2) apt install -y yandex-browser-beta ; sleep 1.4 ; clear ;Header ; Brows_list ;;
3) apt install -y firefox ; sleep 1.4 ; clear ; Header ; Brows_list ;;
4) apt install -y chromium-browser ; sleep 1.4 ; clear ; Header ; Brows_list ;;
back) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Brows_list ;;
esac
}

Sec_tools () {
echo "$LRED [+] Select the package: " 
echo -e "$LYELLOW

		[x]  (0-24)\n
		[0]  nmap			[1]  hydra		
		[2]  nikto			[3]  netcat 		
		[4]  sqlmap			[5]  hashcat		
		[6]  httrack			[7]  wireshark		
		[8]  aircrack-ng		[9]  goldeneye		
		[10] dnsrecon			[11] netdiscover		
		[12] kismet			[13] etherape		
		[14] chkrootkit			[15] rkhunter		
		[16] gnupg			[17] openssh		
		[18] snort			[19] ettercap		
		[20] hping3			[21] ngrep		
		[22] john 			[23] dsniff		
		[24] tor - i2p
		[25] Metasploit		$LRED(Requirements == [curl] & [apt-transport-https])$LYELLOW\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in
x) apt install -y nmap hydra nikto netcat sqlmap hashcat httrack wireshark aircrack-ng goldeneye dnsrecon netdiscover kismet etherape chkrootkit rkhunter gnupg openssh-server snort ettercap-text-only hping3 ngrep john dsniff tor i2p; sleep 1.4 ; clear ;Header ; Sec_tools ;;
0) apt install -y nmap ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
1) apt install -y hydra ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
2) apt install -y nikto ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
3) apt install -y netcat ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
4) apt install -y sqlmap ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
5) apt install -y hashcat ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
6) apt install -y httrack ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
7) apt install -y wireshark ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
8) apt install -y aircrack-ng ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
9) apt install -y goldeneye ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
10) apt install -y dnsrecon ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
11) apt install -y netdiscover ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
12) apt install -y kismet ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
13) apt install -y etherape ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
14) apt install -y chkrootkit ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
15) apt install -y rkhunter ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
16) apt install -y gnupg ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
17) apt install -y openssh-server ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
18) apt install -y snort ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
19) apt install -y ettercap-text-only ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
20) apt install -y hping3 ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
21) apt install -y ngrep ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
22) apt install -y john ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
23) apt install -y dsniff ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
24) apt install -y tor i2p ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

25) cd /tmp/
	curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
	chmod 755 msfinstall && \
	./msfinstall
	sleep 1.4 ; clear ; Header ; Sec_tools ;;
back) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Sec_tools ;;
esac
}

edit_ide_list () {
echo "$LRED [+] Select the package: " 
echo -e "$LYELLOW
	IDE :
		[0] Spyder3
		[1] Eclipse
		[2] Netbeans
 		[3] CodeBlocks\n
 	Editors :
		[4] Code		$LRED(need to add Repository)$LYELLOW
		[5] Pluma
		[6] Leafpad
		[7] Sublime-text	$LRED(need to add Repository)$LYELLOW\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) apt install -y spyder3 ; sleep 1.4 ; clear ;Header ; edit_ide_list ;;
1) apt install -y eclipse ; sleep 1.4 ; clear ;Header ; edit_ide_list ;;
2) apt install -y netbeans ; sleep 1.4 ; clear ;Header ; edit_ide_list ;;
3) apt install -y codeblocks codeblocks-contrib ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;

4) apt install -y code ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
5) apt install -y pluma ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
6) apt install -y leafpad ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
7) apt install -y sublime-text ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
back) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; edit_ide_list ;;
esac
}

Multi_med_list () {
echo "$LRED [+] Select the package: " 
echo -e "$LYELLOW
		[0] VLC
		[1] Gimp
		[2] Shotwell
		[3] Audacity
		[4] Kdenlive\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) apt install -y vlc ; sleep 1.4 ; clear ; Header ; Multi_med_list ;;
1) apt install -y gimp ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
2) apt install -y shotwell ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
3) apt install -y audacity ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
4) apt install -y kdenlive ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
back) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Multi_med_list ;;
esac
}

Extras () {
echo "$LRED [+] Select the package: " 
echo -e "$LYELLOW
		[0] All Packages
		[1] Putty
		[2] Openvpn
		[3] Bleachbit
		[4] VirtualBox
		[5] gnome-tweak-tool
		[6] ubuntu-restricted-extras
		[7] gnome-software-plugin-flatpak

	Chatting
		[8] Signal		(need to add repository)
		[9] Telegram
		\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in
0) apt install -y putty openvpn bleachbit virtualbox gnome-tweak-tool ubuntu-restricted-extras gnome-software-plugin-flatpak ; sleep 1.4 ; clear ; Header ; Apt_list ;;
1) apt install -y putty ; sleep 1.4 ; clear ; Header ; Extras ;;
2) apt install -y openvpn ; sleep 1.4 ; clear ;Header ; Extras ;;
3) apt install -y bleachbit ; sleep 1.4 ; clear ;Header ; Extras ;;
4) apt install -y virtualbox ; sleep 1.4 ; clear ;Header ; Extras ;;
5) apt install -y gnome-tweak-tool ; sleep 1.4 ; clear ;Header ; Extras ;;
6) apt install -y ubuntu-restricted-extras ; sleep 1.4 ; clear ;Header ; Extras ;;
7) apt install -y gnome-software-plugin-flatpak ; sleep 1.4 ; clear ;Header ; Extras ;;
8) apt install -y signal-desktop ; sleep 1.4 ; clear ;Header ; Extras ;;
9) apt install -y telegram-desktop ; sleep 1.4 ; clear ;Header ; Extras ;;
back) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Extras ;;
esac
}

Snap_list () {
echo "$LRED [+] Select the package: " 
echo -e "$LYELLOW
		[0] Discord
		[1] Zoom-client\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) apt install libgconf-2-4 libappindicator1 ; sleep 0.2 ; snap install discord ; sleep 1.4 ; clear ; Header ; Snap_list ;;
1) snap install zoom-client ; sleep 1.4 ; clear ;Header ; Snap_list ;;
back) clear ; Header ; Install_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Snap_list ;;
esac
}

Pip_list () {
echo "$LRED [+] Select the package: " 
echo -e "$LYELLOW
		[0] Tensorflow
		[1] Keras
		[2] Opencv-python
		[3] Imutils
		[4] Numpy
		[5] Matplotlib
		[6] Pytesseract
		[7] Python-docx
		[8] Docx2txt\n\n
		[back]\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) pip install tensorflow ; sleep 1.4 ; clear ; Header ; Pip_list ;;
1) pip install Keras ; sleep 1.4 ; clear ;Header ; Pip_list ;;
2) pip install opencv-python ; sleep 1.4 ; clear ;Header ; Pip_list ;;
3) pip install imutils ; sleep 1.4 ; clear ;Header ; Pip_list ;;
4) pip install numpy ; sleep 1.4 ; clear ;Header ; Pip_list ;;
5) pip install matplotlib ; sleep 1.4 ; clear ;Header ; Pip_list ;;
6) pip install pytesseract ; sleep 1.4 ; clear ;Header ; Pip_list ;;
7) pip install python-docx ; sleep 1.4 ; clear ;Header ; Pip_list ;;
8) pip install docx2txt ; sleep 1.4 ; clear ;Header ; Pip_list ;;
back) clear ; Header ; Install_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Pip_list ;;
esac
}

main_menu () {
echo -e "[+] Choose option :$Color_Off$LYELLOW\n
		[0] Add Repository
		[1] Install packages & tools\n\n
		[2] Update & Upgrade $LRED(apt Packages)$LYELLOW
		[3] Update & Upgrade $LRED(snap Packages)$LYELLOW
		[4] Update All Python Packages $LRED(pip Packages)\n\n
$LRED		[exit]\n$Color_Off"
read -p "[+] Enter Your choice : " choice

clear;

Header
case $choice in
	0) Repo_list ;;
	1) Install_list ;;
	2) apt -y update ; sleep 1.4 ; apt -y full-upgrade ; sleep 1.4 ; clear ; Header ; main_menu ;;
	3) snap refresh ; sleep 1.4 ; clear ; Header ; main_menu  ;;
	4) pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U ; sleep 1.4 ; clear ; Header ; main_menu ;;
	exit) echo -e "【 Thank you for using my script , Good luck ❤️  】  \n";exit ;;
	*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; main_menu ;;
	esac
}

trap ctrl_c INT
ctrl_c() {
echo -e "\n\n$LRED[+] CTRL+C PRESSED !$Color_Off" ; sleep 1.5
clear ; exit ;
}

Header
main_menu
