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
GRAY=$(			printf '\033[1;37m')
LGRAY=$(		printf '\033[0;37m')

if [ $(id -u) != "0" ]; then
	echo "$LRED[✖] You must be root to do that! [✖]$Color_Off"
	exit
fi  

reset

Header () {
echo \
"$GRAY ============================================================
$GRAY |$YELLOW		        SuperRepository		 $GRAY	    |
$GRAY |$YELLOW			 ____  ____  			 $GRAY   |
$GRAY |$YELLOW			/ ___||  _ \ 			 $GRAY   |
$GRAY |$YELLOW			\___ \| |_) |			 $GRAY   |
$GRAY |$YELLOW			 ___) |  _ < 			 $GRAY   |
$GRAY |$YELLOW			|____/|_| \_\			 $GRAY   |
$GRAY |							 $GRAY   |
$GRAY |	  	     	  $BLUE MrM8BRH	 		   $GRAY |
$GRAY |							 $GRAY   |
$GRAY ============================================================$Color_Off";
}

Repo_list () {
echo -e "[+] Select the Repository:\n
		[$RED i $Color_Off] Install Requirements\n
		[$RED 0 $Color_Off] Signal - Private Messenger\n
		[$RED 1 $Color_Off] Sublime Text\n
		[$RED 2 $Color_Off] Brave Browser\n
		[$RED 3 $Color_Off] Opera Browser\n
		[$RED 4 $Color_Off] Yandex browser\n
		[$RED 5 $Color_Off] Visual Studio Code\n
		[$RED 6 $Color_Off] Graphics drivers (Nvidia)\n\n
		[$RED b $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in
i)	apt update ; apt install -y curl wget software-properties-common; sleep 1.4 ; clear ; Header ; Repo_list ;;

0)	curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add - ; sleep 1.4;
	echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

1)	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - ; sleep 1.4;
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

2)	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - ;sleep 1.4;
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list ; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

3)	wget -qO- https://deb.opera.com/archive.key | sudo apt-key add - ; sleep 1.4;
	sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free" ; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

4)	wget -qO-  https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | sudo apt-key add - ; sleep 1.4;
	echo "deb [arch=amd64] http://repo.yandex.ru/yandex-browser/deb beta main" > /etc/apt/sources.list.d/yandex-browser-beta.list ; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

5)	cd /tmp/ ; sleep 1.4;
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg ; sleep 1.4;
	sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ ; sleep 1.4;
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' ; sleep 1.4;
	cd -; sleep 1.4;
	apt update ; clear ; Header ; Repo_list ;;

6)	sudo add-apt-repository ppa:graphics-drivers/ppa ; apt update ; clear ; Header ; Repo_list ;;

b) clear ; Header ; main_menu ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Repo_list ;;
esac
}

Install_list () {
echo -e "\n$LGREEN** Make sure the repositories are updated **\n$Color_Off"
echo -e "[+] Select the package manager:\n
		[$RED 1 $Color_Off] ==> Apt Packages\n
		[$RED 2 $Color_Off] ==> Snap Packages\n
		[$RED 3 $Color_Off] ==> Pip3 Packages\n
		[$RED 4 $Color_Off] ==> Npm Packages\n\n
		[$RED b $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in

1) clear ; Header ; Apt_list;;
2) clear ; Header ; Snap_list;;
3) clear ; Header ; Pip_list;;
4) clear ; Header ; Npm_list;;
b) clear ; Header ; main_menu ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Install_list ;;
esac
}

Apt_list () {
echo -e "[+] Select the package:\n
		[$RED 0 $Color_Off] Essential packages\n
		[$RED 1 $Color_Off] Programming Languages\n
		[$RED 2 $Color_Off] Browsers\n
		[$RED 3 $Color_Off] Security Tools\n
		[$RED 4 $Color_Off] Text Editors & IDE\n
		[$RED 5 $Color_Off] Multimedia\n
		[$RED 6 $Color_Off] Extras - Chatting\n\n
		[$RED b $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in

0) clear ; Header ; Primary_list ;;
1) clear ; Header ; Prog_lan_list ;;
2) clear ; Header ; Brows_list ;;
3) clear ; Header ; Sec_tools ;;
4) clear ; Header ; edit_ide_list;;
5) clear ; Header ; Multi_med_list;;
6) clear ; Header ; Extras;;
b) clear ; Header ; Install_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Apt_list ;;
esac
}

Primary_list () {
echo -e "[+] Select the package: \n
		[$RED a $Color_Off]  (1-8)\n
		[$RED 1 $Color_Off] git , curl , wget \t [$RED 2 $Color_Off] net-tools , gufw , htop\n
		[$RED 3 $Color_Off] build-essential , dpkg \t [$RED 4 $Color_Off] apt-transport-https\n
		[$RED 5 $Color_Off] rar , unrar , engrampa \t [$RED 6 $Color_Off] software properties common\n
		[$RED 7 $Color_Off] Kernel Headers \t\t [$RED 8 $Color_Off] exFAT\n
		

		[$RED 01 $Color_Off]  snap ==> (Snap Packages)\n
		[$RED 02 $Color_Off]  pip3 ==> (Python3 package installer)\n
		[$RED 03 $Color_Off]  npm  ==> (Node Package Manager)\n\n
		[$RED b  $Color_Off]  back\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in
a) apt install -y git wget curl gufw htop dpkg net-tools build-essential apt-transport-https rar unrar engrampa software-properties-common linux-headers-$(uname -r) exfat-fuse exfat-utils ; sleep 1.4 ; clear ; Header ; Apt_list ;;
1) apt install -y git curl wget; sleep 1.4 ; clear ;Header ; Primary_list ;;
2) apt install -y net-tools gufw htop ; sleep 1.4 ; clear ; Header ; Primary_list ;;
3) apt install -y build-essential dpkg ; sleep 1.4 ; clear ; Header ; Primary_list ;;
4) apt install -y apt-transport-https; sleep 1.4 ; clear ; Header ; Primary_list ;;
5) apt install -y rar unrar engrampa; sleep 1.4 ; clear ; Header ; Primary_list ;;
6) apt install -y software-properties-common; sleep 1.4 ; clear ; Header ; Primary_list ;;
7) apt install -y linux-headers-$(uname -r); sleep 1.4 ; clear ; Header ; Primary_list ;;
8) apt install -y exfat-fuse exfat-utils; sleep 1.4 ; clear ; Header ; Primary_list ;;
01) apt install -y snap snapd; sleep 1.4 ; clear ; Header ; Primary_list ;;
02) apt install -y python3-pip ; sudo -H pip3 install --upgrade pip ; sleep 1.4 ; clear ; Header ; Primary_list ;;
03) apt install -y npm ; npm install -g npm@next ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;

b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Primary_list ;;
esac
}

Prog_lan_list () {
echo -e "[+] Select the package:\n
		[$RED 0 $Color_Off] C++
		
		[$RED 1 $Color_Off] Java 8 - [$RED 2 $Color_Off] Java 11 - [$RED 3 $Color_Off] Java 14
		
		[$RED 4 $Color_Off] Ruby
		[$RED 5 $Color_Off] Python3

		[$RED 6 $Color_Off] PHP
		[$RED 7 $Color_Off] PhpMyAdmin
		[$RED 8 $Color_Off] NodeJS

		[$RED 9 $Color_Off]  MySql
		[$RED 10 $Color_Off] Postgresql

		[$RED 11 $Color_Off] Nginx
		[$RED 12 $Color_Off] Apache2 \n\n
		[$RED b  $Color_Off] back\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) apt install -y g++ ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;
1) apt install -y openjdk-8-jre openjdk-8-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
2) apt install -y openjdk-11-jre openjdk-11-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
3) apt install -y openjdk-14-jre openjdk-14-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
4) apt install -y ruby ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
5) apt install -y python3 python3-tk ; sudo -H pip3 install --upgrade pip ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
6) apt install -y php ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
7) apt install -y phpmyadmin ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
8) apt install -y nodejs ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;
9) apt install -y mysql-server mysql-client ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
10) apt install -y postgresql ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
11) apt install -y nginx ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
12) apt install -y apache2 ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Prog_lan_list ;;
esac
}

Brows_list () {
echo -e "[+] Select the package:\n
		[$RED 0 $Color_Off] Brave\n
		[$RED 1 $Color_Off] Opera\n
		[$RED 2 $Color_Off] Yandex\n
 		[$RED 3 $Color_Off] Firefox\n
		[$RED 4 $Color_Off] Chromium\n\n
		[$RED b $Color_Off] back\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) apt install -y brave-browser ; sleep 1.4 ; clear ;Header ; Brows_list ;;
1) apt install -y opera-stable ; sleep 1.4 ; clear ;Header ; Brows_list ;;
2) apt install -y yandex-browser-beta ; sleep 1.4 ; clear ;Header ; Brows_list ;;
3) apt install -y firefox ; sleep 1.4 ; clear ; Header ; Brows_list ;;
4) apt install -y chromium-browser ; sleep 1.4 ; clear ; Header ; Brows_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Brows_list ;;
esac
}

Sec_tools () {
echo -e "[+] Select the tool:\n
	Networks:
		[$RED n   $Color_Off]  (n0-n15)\n
		[$RED n0  $Color_Off] Nmap \t\t [$RED n1  $Color_Off] Masscan\n
		[$RED n2  $Color_Off] Netdiscover \t [$RED n3  $Color_Off] Snort\n
		[$RED n4  $Color_Off] Ettercap \t [$RED n5  $Color_Off] Etherape\n
		[$RED n6  $Color_Off] OpenSSH \t [$RED n7  $Color_Off] Hping3\n
		[$RED n8  $Color_Off] Wireshark \t [$RED n9  $Color_Off] Netcat\n
		[$RED n10 $Color_Off] Ngrep \t\t [$RED n11 $Color_Off] Dsniff\n
		[$RED n12 $Color_Off] GoldenEye \t [$RED n13 $Color_Off] OpenVas\n
		[$RED n14 $Color_Off] Aircrack-Ng \t [$RED n15 $Color_Off] MDK4\n
	Forensics:
		[$RED f  $Color_Off] (f0-f9)\n
		[$RED f0 $Color_Off] Forensics All \t [$RED f1 $Color_Off] Exiftool\n
		[$RED f2 $Color_Off] Binwalk \t\t [$RED f3 $Color_Off] Foremost\n
		[$RED f4 $Color_Off] Steghide \t [$RED f5 $Color_Off] Visualvm\n
		[$RED f6 $Color_Off] Chkrootkit \t [$RED f7 $Color_Off] Rkhunter\n
		[$RED f8 $Color_Off] Unhide \t\t [$RED f9 $Color_Off] Forensics Extra\n
	Web:
		[$RED w  $Color_Off] (w0-w6)\n
		[$RED w0 $Color_Off] Sqlmap \t\t [$RED w1 $Color_Off] Wafw00f\n
		[$RED w2 $Color_Off] Nikto \t\t [$RED w3 $Color_Off] Httrack\n
		[$RED w4 $Color_Off] Gobuster \t [$RED w5 $Color_Off] Wapiti\n
		[$RED w6 $Color_Off] DnsRecon\n
	Crack:
		[$RED c  $Color_Off] (c0-c4)\n
		[$RED c0 $Color_Off] Hashcat \t\t [$RED c1 $Color_Off] John The Ripper\n
		[$RED c2 $Color_Off] Hydra \t\t [$RED c3 $Color_Off] Cewl\n
		[$RED c4 $Color_Off] Crunch\n
	Other:
		[$RED o  $Color_Off] (o0-o5)\n
		[$RED o0 $Color_Off] Yara \t\t [$RED o1 $Color_Off] Apktool\n
		[$RED o2 $Color_Off] TOR \t\t [$RED o3 $Color_Off] I2P\n
		[$RED o4 $Color_Off] Gnupg \t\t [$RED o5 $Color_Off] edb Debugger\n
		[$RED o6 $Color_Off] Metasploit\n\n
		[$RED b  $Color_Off]  back\n"
read -p "[!] Your choice: " choice
case $choice in
n) apt install -y nmap masscan netdiscover snort ettercap-text-only etherape openssh-server hping3 wireshark netcat ngrep dsniff goldeneye openvas aircrack-ng mdk4; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n0) apt install -y nmap ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n1) apt install -y masscan ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n2) apt install -y netdiscover ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n3) apt install -y snort ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n4) apt install -y ettercap-text-only ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n5) apt install -y etherape ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n6) apt install -y openssh-server ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n7) apt install -y hping3 ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n8) apt install -y wireshark ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n9) apt install -y netcat ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n10) apt install -y ngrep ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n11) apt install -y dsniff ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n12) apt install -y goldeneye ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n13) apt install -y openvas ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
n14) apt install -y aircrack-ng ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n15) apt install -y mdk4 ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

f) apt install -y forensics-all exiftool binwalk foremost steghide visualvm chkrootkit rkhunter unhide forensics-extra; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f0) apt install -y forensics-all ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f1) apt install -y exiftool ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f2) apt install -y binwalk ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f3) apt install -y foremost ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f4) apt install -y steghide ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f5) apt install -y visualvm ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f6) apt install -y chkrootkit ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f7) apt install -y rkhunter ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f8) apt install -y unhide ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
f9) apt install -y forensics-extra ; sleep 1.4 ; clear ;Header ; Sec_tools ;;

w) apt install -y sqlmap wafw00f nikto httrack gobuster wapiti dnsrecon; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w0) apt install -y sqlmap ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w1) apt install -y wafw00f ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w2) apt install -y nikto ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w3) apt install -y httrack ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w4) apt install -y gobuster ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w5) apt install -y wapiti ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w6) apt install -y dnsrecon ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

c) apt install -y hashcat john hydra cewl crunch ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
c0) apt install -y hashcat ; sleep 1.4 ; clear ;Header ; Sec_tools ;;
c1) apt install -y john ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c2) apt install -y hydra ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c3) apt install -y cewl ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c4) apt install -y crunch ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

o) apt install -y yara apktool tor i2p gnupg edb-debugger ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o0) apt install -y yara ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o1) apt install -y apktool ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o2) apt install -y tor ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o3) apt install -y i2p ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o4) apt install -y gnupg ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o5) apt install -y edb-debugger ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o6) apt install -y curl apt-transport-https; cd /tmp/
	curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
	chmod 755 msfinstall && \
	./msfinstall
	sleep 1.4 ; clear ; Header ; Sec_tools ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Sec_tools ;;
esac
}

edit_ide_list () {
echo -e "[+] Select the package:\n
	IDE :
		[$RED 0 $Color_Off] Spyder3\n
		[$RED 1 $Color_Off] Netbeans\n
 		[$RED 2 $Color_Off] CodeBlocks\n\n
 	Editors :
		[$RED 3 $Color_Off] VS Code \t [$RED 4 $Color_Off] Pluma\n
		[$RED 5 $Color_Off] Emacs \t [$RED 6 $Color_Off] Sublime-text\n
		[$RED 7 $Color_Off] VIM\n\n
		[$RED b $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in

0) apt install -y spyder3 ; sleep 1.4 ; clear ;Header ; edit_ide_list ;;
1) apt install -y netbeans ; sleep 1.4 ; clear ;Header ; edit_ide_list ;;
2) apt install -y codeblocks codeblocks-contrib ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;

3) apt install -y code ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
4) apt install -y pluma ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
5) apt install -y emacs ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
6) apt install -y sublime-text ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
7) apt install -y vim ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; edit_ide_list ;;
esac
}

Multi_med_list () {
echo -e "[+] Select the package:\n
		[$RED 0 $Color_Off] VLC\n
		[$RED 1 $Color_Off] Gimp\n
		[$RED 2 $Color_Off] Shotwell\n
		[$RED 3 $Color_Off] Audacity\n
		[$RED 4 $Color_Off] Kdenlive\n\n
		[$RED b $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in

0) apt install -y vlc ; sleep 1.4 ; clear ; Header ; Multi_med_list ;;
1) apt install -y gimp ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
2) apt install -y shotwell ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
3) apt install -y audacity ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
4) apt install -y kdenlive ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Multi_med_list ;;
esac
}

Extras () {
echo -e "[+] Select the package:\n
		[$RED a $Color_Off] (1-6)\n
		[$RED 1 $Color_Off] Putty \t\t [$RED 2 $Color_Off] Openvpn\n
		[$RED 3 $Color_Off] Bleachbit \t [$RED 4 $Color_Off] Virtualbox\n
		[$RED 5 $Color_Off] Gnome Tweak Tool \t [$RED 6 $Color_Off] Gnome Software Plugin Flatpak\n
		-------
		[$RED 7 $Color_Off] VMware Guest Tools\n
	Chatting
		[$RED 8 $Color_Off] Signal \t\t [$RED 9 $Color_Off] Telegram\n\n
		[$RED b $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in
a) apt install -y putty openvpn bleachbit virtualbox gnome-tweak-tool gnome-software-plugin-flatpak ; sleep 1.4 ; clear ; Header ; Apt_list ;;
1) apt install -y putty ; sleep 1.4 ; clear ; Header ; Extras ;;
2) apt install -y openvpn ; sleep 1.4 ; clear ;Header ; Extras ;;
3) apt install -y bleachbit ; sleep 1.4 ; clear ;Header ; Extras ;;
4) apt install -y virtualbox ; sleep 1.4 ; clear ;Header ; Extras ;;
5) apt install -y gnome-tweak-tool ; sleep 1.4 ; clear ;Header ; Extras ;;
6) apt install -y gnome-software-plugin-flatpak ; sleep 1.4 ; clear ;Header ; Extras ;;
7) apt install -y open-vm-tools ; sleep 1.4 ; clear ;Header ; Extras ;;
8) apt install -y signal-desktop ; sleep 1.4 ; clear ;Header ; Extras ;;
9) apt install -y telegram-desktop ; sleep 1.4 ; clear ;Header ; Extras ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Extras ;;
esac
}

Snap_list () {
echo -e "[+] Select the package:\n\n
		[$RED 0 $Color_Off] Discord \t  [$RED 1 $Color_Off] Zoom-client\n
		[$RED 2 $Color_Off] Eclipse \t  [$RED 3 $Color_Off] Apache NetBeans\n
		[$RED 3 $Color_Off] PyCharm \t  [$RED 4 $Color_Off] Atom\n
		[$RED 5 $Color_Off] DrMIPS \t  [$RED 6 $Color_Off] youtube-dl\n\n
		[$RED b $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in

0) apt install -y libgconf-2-4 libappindicator1 ; sleep 0.2 ; snap install discord ; sleep 1.4 ; clear ; Header ; Snap_list ;;
1) snap install zoom-client ; sleep 1.4 ; clear ;Header ; Snap_list ;;
2) snap install eclipse --classic ; sleep 1.4 ; clear ;Header ; Snap_list ;;
3) snap install netbeans --classic ; sleep 1.4 ; clear ;Header ; Snap_list ;;
4) snap install atom --classic ; sleep 1.4 ; clear ;Header ; Snap_list ;;
5) snap install drmips ; sleep 1.4 ; clear ;Header ; Snap_list ;;
6) snap install youtube-dl ; sleep 1.4 ; clear ;Header ; Snap_list ;;

b) clear ; Header ; Install_list ;;
*) echo -e "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Snap_list ;;
esac
}

Pip_list () {
echo -e "[+] Select the package:\n
	AI - ML:
		[$RED 0 $Color_Off] Jupyter Notebook \t  [$RED 1 $Color_Off] Tensorflow\n
		[$RED 2 $Color_Off] Keras \t\t  [$RED 3 $Color_Off] Opencv-python\n
		[$RED 4 $Color_Off] Imutils \t\t  [$RED 5 $Color_Off] Numpy\n
		[$RED 6 $Color_Off] Matplotlib \t  [$RED 7 $Color_Off] Pytesseract\n
		[$RED 8 $Color_Off] Python-docx \t  [$RED 9 $Color_Off] Docx2txt\n
	Security:
		[$RED 10 $Color_Off] Shodan \t\t  [$RED 11 $Color_Off] BadChars\n
		[$RED 12 $Color_Off] Pillow \t\t  [$RED 13 $Color_Off] Requests\n
		[$RED 14 $Color_Off] Scapy \t\t  [$RED 15 $Color_Off] Cryptography\n
		[$RED 16 $Color_Off] Impacket\n\n

		[$RED b  $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in
0) pip3 install notebook ; sleep 1.4 ; clear ; Header ; Pip_list ;;
1) pip3 install tensorflow ; sleep 1.4 ; clear ; Header ; Pip_list ;;
2) pip3 install Keras ; sleep 1.4 ; clear ;Header ; Pip_list ;;
3) pip3 install opencv-python ; sleep 1.4 ; clear ;Header ; Pip_list ;;
4) pip3 install imutils ; sleep 1.4 ; clear ;Header ; Pip_list ;;
5) pip3 install numpy ; sleep 1.4 ; clear ;Header ; Pip_list ;;
6) pip3 install matplotlib ; sleep 1.4 ; clear ;Header ; Pip_list ;;
7) pip3 install pytesseract ; sleep 1.4 ; clear ;Header ; Pip_list ;;
8) pip3 install python-docx ; sleep 1.4 ; clear ;Header ; Pip_list ;;
9) pip3 install docx2txt ; sleep 1.4 ; clear ;Header ; Pip_list ;;
10) pip3 install shodan ; sleep 1.4 ; clear ;Header ; Pip_list ;;
11) pip3 install badchars ; sleep 1.4 ; clear ;Header ; Pip_list ;;
12) pip3 install pillow ; sleep 1.4 ; clear ;Header ; Pip_list ;;
13) pip3 install requests ; sleep 1.4 ; clear ;Header ; Pip_list ;;
14) pip3 install scapy ; sleep 1.4 ; clear ;Header ; Pip_list ;;
15) pip3 install cryptography ; sleep 1.4 ; clear ;Header ; Pip_list ;;
16) pip3 install impacket ; sleep 1.4 ; clear ;Header ; Pip_list ;;
b) clear ; Header ; Install_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Pip_list ;;
esac
}

Npm_list () {
echo -e "[+] Select the package:\n
		[$RED 0 $Color_Off] Pacote\n
		[$RED 1 $Color_Off] Global Dirs\n
		[$RED 2 $Color_Off] Depcheck\n
		[$RED 3 $Color_Off] Types Registry\n
		[$RED 4 $Color_Off] Pnpm\n
		[$RED 5 $Color_Off] Inspectpack\n
		[$RED 6 $Color_Off] Npm gui\n\n
		[$RED b $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in

0) npm install pacote ; sleep 1.4 ; clear ; Header ; Npm_list ;;
1) npm install global-dirs ; sleep 1.4 ; clear ;Header ; Npm_list ;;
2) npm install depcheck ; sleep 1.4 ; clear ;Header ; Npm_list ;;
3) npm install types-registry ; sleep 1.4 ; clear ;Header ; Npm_list ;;
4) npm install pnpm ; sleep 1.4 ; clear ;Header ; Npm_list ;;
5) npm install inspectpack ; sleep 1.4 ; clear ;Header ; Npm_list ;;
6) npm install npm-gui ; sleep 1.4 ; clear ;Header ; Npm_list ;;
b) clear ; Header ; Install_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Npm_list ;;
esac
}

Upd_Upg_list () {
echo -e "[+] Select the package:\n
		[$RED 0 $Color_Off] Update & Upgrade ==> (apt Packages)\n
		[$RED 1 $Color_Off] Update All Snap Packages ==> (snap Packages)\n
		[$RED 2 $Color_Off] Update All Python Packages ==> (pip3 Packages)\n
		[$RED 3 $Color_Off] Update All Node Packages ==> (npm Packages)\n\n
		[$RED b $Color_Off] back\n"
read -p "[!] Your choice: " choice
case $choice in

0) apt -y update ; sleep 1.4 ; apt -y full-upgrade ; sleep 1.4 ; clear ; Header ; Upd_Upg_list ;;
1) snap refresh ; sleep 1.4 ; clear ; Header ; Upd_Upg_list  ;;
2) sudo -H pip3 install --upgrade pip; pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U ; sleep 1.4 ; clear ; Header ; Upd_Upg_list ;;
3) npm update -g ; sleep 1.4 ; clear ; Header ; Upd_Upg_list ;;
b) clear ; Header ; main_menu ;;
*) echo -e "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Upd_Upg_list ;;
esac
}

main_menu () {
echo -e "[+] Choose option :\n
		[$RED 0 $Color_Off] Add Repository\n
		[$RED 1 $Color_Off] Install packages & tools\n
		[$RED 2 $Color_Off] Update & Upgrade\n\n
		[$RED e $Color_Off] exit\n"
read -p "[+] Enter Your choice : " choice

clear;

Header
case $choice in
	0) Repo_list ;;
	1) Install_list ;;
	2) Upd_Upg_list ;;
	e) echo -e "【 Thank you for using my script , Good luck ❤️  】  \n"; exit ;;
	*) echo -e "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; main_menu ;;
	esac
}

trap ctrl_c INT
ctrl_c() {
echo -e "\n\n$LRED[+] CTRL+C PRESSED !$Color_Off" ; sleep 1.5
clear ; exit ;
}

Header
main_menu
