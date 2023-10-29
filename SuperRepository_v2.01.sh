#!/bin/bash

# Define ANSI escape codes for text colors
Color_Off=$(printf '\033[0m')   # Reset all attributes
RED=$(printf '\033[00;31m')     # Dark red
GREEN=$(printf '\033[00;32m')   # Dark green
YELLOW=$(printf '\033[00;33m')  # Dark yellow
BLUE=$(printf '\033[00;34m')    # Dark blue
GRAY=$(printf '\033[1;30m')     # Dark gray
LRED=$(printf '\033[01;31m')    # Light red
LGREEN=$(printf '\033[01;32m')  # Light green
LGRAY=$(printf '\033[1;37m')    # Light gray
############################################################################################
# Check if the current user is not root (i.e., does not have administrative privileges)
if [ $(id -u) != "0" ]; then
    # If not, print an error message in red and exit the script
    echo "$LRED[✖] You must be root to do that! [✖]$Color_Off" ; exit ;
fi
clear
############################################################################################
Header () {
echo "$LGRAY┌─────────────────────────────────────────────────────────────────────────────────┐
│                                                                                 │
│$LGREEN   ____                        ____                      _ _                     $LGRAY│
│$LGREEN  / ___| _   _ _ __   ___ _ __|  _ \ ___ _ __   ___  ___(_| |_ ___  _ __ _   _   $LGRAY│
│$LGREEN  \___ \| | | | '_ \ / _ | '__| |_) / _ | '_ \ / _ \/ __| | __/ _ \| '__| | | |  $LGRAY│
│$LGREEN   ___) | |_| | |_) |  __| |  |  _ |  __| |_) | (_) \__ | | || (_) | |  | |_| |  $LGRAY│
│$LGREEN  |____/ \__,_| .__/ \___|_|  |_| \_\___| .__/ \___/|___|_|\__\___/|_|   \__, |  $LGRAY│
│$LGREEN              |_|                       |_|                              |___/   $LGRAY│
│$BLUE                     Author: MrM8BRH                                             $LGRAY│
│$YELLOW                                              V2.01                 $LGRAY             │
└─────────────────────────────────────────────────────────────────────────────────┘$Color_Off"
}
############################################################################################
main_menu () {
echo -e "[+] Choose one of the following :\n
	[$RED 0 $Color_Off] Add Repository\n
	[$RED 1 $Color_Off] Install Packages & Tools\n
	[$RED 2 $Color_Off] Update & Upgrade All Packages \n\n
	[$RED e $Color_Off] Exit / CTRL+C \n"
read -p "[+] Enter Your choice : " choice

clear ;

Header
case $choice in
	0) Repo_list ;;
	1) Install_list ;;
	2) Upd_Upg_list ;;
	e) clear ; exit ;;
	*) echo -e "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; main_menu ;;
	esac
}
############################################################################################
# Set up a trap to capture the interrupt signal (CTRL+C)
trap ctrl_c INT

# Define the ctrl_c function
ctrl_c() {
    # Clear the screen and exit the script
    clear ; exit ;
}
############################################################################################
# Function to handle cache lock
handle_lock() {
    # Function to forcibly release the lock
    force_release_lock() {
        sudo fuser -vki /var/lib/dpkg/lock-frontend
        echo "Lock forcibly released."
    }

    # Check if the lock is held
    if fuser /var/lib/dpkg/lock-frontend &>/dev/null; then
        echo "A process is holding the cache lock."
        read -p "Do you want to force release it? (y/n): " choice
        case "$choice" in
            y|Y ) force_release_lock ;;
            * ) echo "Waiting for cache lock to be released..."
                while fuser /var/lib/dpkg/lock-frontend &>/dev/null; do
                    sleep 1
                done
                echo "Lock released, continuing with the script."
                ;;
        esac
    else
        echo "No cache lock is currently held."
    fi
}
############################################################################################
install_with_progress () {
    local packages=("$@")

    echo -n "Updating repositories: ["
    `sudo apt update -y > /dev/null 2>&1` & PID=$!
    while kill -0 $PID 2>/dev/null; do 
        printf "-"
        sleep 3
    done
    echo -ne "] done! \n"

    for package in "${packages[@]}"; do
        if dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q "install ok installed"; then
            echo "Package $LGREEN'$package'$Color_Off is already installed."
        else
            if ! apt-cache show "$package" &>/dev/null; then
                echo "Package $LRED'$package'$Color_Off not found in repositories."
            else
                echo -n "Installing $LGREEN'$package'$Color_Off: ["
                sudo apt install -y "$package" > /dev/null 2>&1 &

                local pid=$!
                local delay=3

                while ps -p $pid &>/dev/null; do
                    echo -n "-"
                    sleep $delay
                done

                if [ $? -eq 0 ]; then
                    echo -ne "] done! \n"
                else
                    echo -ne "] $LRED Error installing '$package' $Color_Off \n"
                fi
            fi
        fi
    done

    echo "Installation process completed."
    sleep 2
}
############################################################################################
fix_trusted_gpg_issue () {
    echo "Fixing trusted.gpg issue..."
    for KEY in $( \
        apt-key --keyring /etc/apt/trusted.gpg list \
        | grep -E "(([ ]{1,2}(([0-9A-F]{4}))){10})" \
        | tr -d " " \
        | grep -E "([0-9A-F]){8}\b" \
    ); do
        K=${KEY:(-8)}
        # Remove existing file, if it exists
        sudo rm -f /etc/apt/trusted.gpg.d/imported-from-trusted-gpg-$K.gpg

        apt-key export $K \
        | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/imported-from-trusted-gpg-$K.gpg
    done
    echo "Trusted.gpg issue resolved."
    sleep 2
}
############################################################################################
Repo_list () {
echo -e "[+] Select the Repository:\n
		[$RED i $Color_Off] Install Requirements\n
		[$RED f $Color_Off] Fix trusted.gpg issue\n
		[$RED 0 $Color_Off] Kali Linux software repository\n
		[$RED 1 $Color_Off] Signal - Private Messenger\n
		[$RED 2 $Color_Off] Sublime Text\n
		[$RED 3 $Color_Off] Brave Browser\n
		[$RED 4 $Color_Off] Opera Browser\n
		[$RED 5 $Color_Off] Yandex Browser\n
		[$RED 6 $Color_Off] Flatpak\n
		[$RED 7 $Color_Off] Visual Studio Code\n
		[$RED 8 $Color_Off] Graphics drivers (Nvidia)\n\n
		[$RED b $Color_Off] Back\n"
read -p "[!] Your choice: " choice
case $choice in
i)	handle_lock ; install_with_progress curl wget software-properties-common; clear ; Header ; Repo_list ;;

f)	fix_trusted_gpg_issue ; clear ; Header ; Repo_list ;;

0)	echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" | tee -a /etc/apt/sources.list.d/kali.list ;
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ED444FF07D8D0BF6 ;
	apt update ; clear ; Header ; Repo_list ;;

1)	curl -s https://updates.signal.org/desktop/apt/keys.asc | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/signal.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/signal.gpg ;
	echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee -a /etc/apt/sources.list.d/signal-xenial.list ;
	apt update ; clear ; Header ; Repo_list ;;

2)	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/sublime.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/sublime.gpg ;
	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list ;
	apt update ; clear ; Header ; Repo_list ;;

3)	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/brave.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/brave.gpg ;
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list ;
	apt update ; clear ; Header ; Repo_list ;;

4)	wget -qO- https://deb.opera.com/archive.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/opera.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/opera.gpg
	add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free" ;
	apt update ; clear ; Header ; Repo_list ;;

5)	wget -qO-  https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/yandex.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/yandex.gpg ;
	echo "deb [arch=amd64] http://repo.yandex.ru/yandex-browser/deb beta main" > /etc/apt/sources.list.d/yandex-browser-beta.list ;
	apt update ; clear ; Header ; Repo_list ;;

6)	add-apt-repository ppa:flatpak/stable ; apt install flatpak gnome-software-plugin-flatpak ;
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo ; clear ; Header ; Repo_list ;;

7)	cd /tmp/ ; curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg ;
	install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ ; 
	sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' ; sleep 1.4;
	cd -;
	apt update ; clear ; Header ; Repo_list ;;

8)	add-apt-repository ppa:graphics-drivers/ppa ; apt update ; clear ; Header ; Repo_list ;;

b) clear ; Header ; main_menu ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Repo_list ;;
esac
}
############################################################################################
Apt_list () {
echo -e "\n$LGREEN* Ensure that all required repositories are added\n$Color_Off
		[$RED 0 $Color_Off] Essential packages\n
		[$RED 1 $Color_Off] Programming\n
		[$RED 2 $Color_Off] Browsers\n
		[$RED 3 $Color_Off] Security Tools\n
		[$RED 4 $Color_Off] Text Editors & IDEs\n
		[$RED 5 $Color_Off] Multimedia\n
		[$RED 6 $Color_Off] Extras - Chatting\n\n
		[$RED b $Color_Off] Back\n"
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
############################################################################################
Primary_list () {
echo -e "[+] Choose: \n
		[$RED a $Color_Off] (1-7) \n
		[$RED 1 $Color_Off] git & curl & wget \t [$RED 2 $Color_Off] net-tools & ufw & htop \n
		[$RED 3 $Color_Off] build-essential & dpkg \t [$RED 4 $Color_Off] apt-transport-https \n
		[$RED 5 $Color_Off] synaptic & exFAT \t\t [$RED 6 $Color_Off] kernel headers & dkms \n
		[$RED 7 $Color_Off] rar & unrar & engrampa & gzip \n\n
		[$RED b  $Color_Off]  Back \n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in
a) handle_lock ; install_with_progress git wget curl ufw htop dpkg net-tools build-essential apt-transport-https rar unrar engrampa gzip dkms linux-headers-$(uname -r) synaptic exfat-fuse exfat-utils ; sleep 1.4 ; clear ; Header ; Primary_list ;;
1) handle_lock ; install_with_progress git curl wget; sleep 1.4 ; clear ; Header ; Primary_list ;;
2) handle_lock ; install_with_progress net-tools ufw htop ; sleep 1.4 ; clear ; Header ; Primary_list ;;
3) handle_lock ; install_with_progress build-essential dpkg ; sleep 1.4 ; clear ; Header ; Primary_list ;;
4) handle_lock ; install_with_progress apt-transport-https; sleep 1.4 ; clear ; Header ; Primary_list ;;
5) handle_lock ; install_with_progress synaptic exfat-fuse exfat-utils; sleep 1.4 ; clear ; Header ; Primary_list ;;
6) handle_lock ; install_with_progress linux-headers-$(uname -r) dkms; sleep 1.4 ; clear ; Header ; Primary_list ;;
7) handle_lock ; install_with_progress rar unrar engrampa gzip; sleep 1.4 ; clear ; Header ; Primary_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Primary_list ;;
esac
}
############################################################################################
Prog_lan_list () {
echo -e "[+] Choose: \n
		[$RED 0 $Color_Off] Go 1.19.3 \t [You must restart the system after installation]
		[$RED 1 $Color_Off] C++
		
		[$RED 2 $Color_Off] Java 8 
		[$RED 3 $Color_Off] Java 11 
		[$RED 4 $Color_Off] Java 14
		[$RED 5 $Color_Off] Java 17
		
		[$RED 6 $Color_Off] Ruby & Perl
		[$RED 7 $Color_Off] Python3 & python2

		[$RED 8 $Color_Off] PHP & PhpMyAdmin
		[$RED 9 $Color_Off] NodeJS

		[$RED 10 $Color_Off] MySql
		[$RED 11 $Color_Off] Postgresql

		[$RED 12 $Color_Off] Nginx
		[$RED 13 $Color_Off] Apache2 \n\n
		[$RED b  $Color_Off] Back\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in
0) cd /tmp ; wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz ;
   tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz ;
   echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile ;
   sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
1) handle_lock ; install_with_progress g++ ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;
2) handle_lock ; install_with_progress openjdk-8-jre openjdk-8-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
3) handle_lock ; install_with_progress openjdk-11-jre openjdk-11-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
4) handle_lock ; install_with_progress openjdk-14-jre openjdk-14-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
5) handle_lock ; install_with_progress openjdk-17-jre openjdk-17-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
6) handle_lock ; install_with_progress ruby perl ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
7) handle_lock ; install_with_progress python3 python3-pip python2 ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
8) handle_lock ; install_with_progress php phpmyadmin ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
9) handle_lock ; install_with_progress nodejs ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;
10) handle_lock ; install_with_progress mysql-server mysql-client ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
11) handle_lock ; install_with_progress postgresql ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
12) handle_lock ; install_with_progress nginx ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
13) handle_lock ; install_with_progress apache2 ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Prog_lan_list ;;
esac
}
############################################################################################
Brows_list () {
echo -e "[+] Choose: \n
		[$RED 0 $Color_Off] Brave \t [Need to add the repository] \n
		[$RED 1 $Color_Off] Opera \t [Need to add the repository] \n
		[$RED 2 $Color_Off] Yandex \n
 		[$RED 3 $Color_Off] Firefox \n
		[$RED 4 $Color_Off] Chromium \n\n
		[$RED b $Color_Off] Back \n $Color_Off"
read -p "[!] Your choice: " choice
case $choice in
0) handle_lock ; install_with_progress brave-browser ; sleep 1.4 ; clear ;Header ; Brows_list ;;
1) handle_lock ; install_with_progress opera-stable ; sleep 1.4 ; clear ;Header ; Brows_list ;;
2) handle_lock ; install_with_progress yandex-browser-beta ; sleep 1.4 ; clear ;Header ; Brows_list ;;
3) handle_lock ; install_with_progress firefox ; sleep 1.4 ; clear ; Header ; Brows_list ;;
4) handle_lock ; install_with_progress chromium-browser ; sleep 1.4 ; clear ; Header ; Brows_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Brows_list ;;
esac
}
############################################################################################
edit_ide_list () {
echo -e "[+] Choose: \n
	IDE :
		[$RED 0 $Color_Off] Spyder3 \n
		[$RED 1 $Color_Off] Netbeans \n
 		[$RED 2 $Color_Off] CodeBlocks \n\n
 	Editors :
		[$RED 3 $Color_Off] VS Code \t [$RED 4 $Color_Off] Pluma \n
		[$RED 5 $Color_Off] Emacs \t [$RED 6 $Color_Off] Sublime-text [Need to add the repository] \n
		[$RED 7 $Color_Off] VIM \n\n
		[$RED b $Color_Off] Back \n"
read -p "[!] Your choice: " choice
case $choice in

0) handle_lock ; install_with_progress spyder3 ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
1) handle_lock ; install_with_progress netbeans ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
2) handle_lock ; install_with_progress codeblocks codeblocks-contrib ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;

3) handle_lock ; install_with_progress code ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
4) handle_lock ; install_with_progress pluma ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
5) handle_lock ; install_with_progress emacs ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
6) handle_lock ; install_with_progress sublime-text ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
7) handle_lock ; install_with_progress vim ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; edit_ide_list ;;
esac
}
############################################################################################
Multi_med_list () {
echo -e "[+] Choose: \n
		[$RED 0 $Color_Off] VLC\n
		[$RED 1 $Color_Off] Gimp\n
		[$RED 2 $Color_Off] Shotwell\n
		[$RED 3 $Color_Off] Audacity\n
		[$RED 4 $Color_Off] Kdenlive\n\n
		[$RED b $Color_Off] Back\n"
read -p "[!] Your choice: " choice
case $choice in

0) handle_lock ; install_with_progress vlc ; sleep 1.4 ; clear ; Header ; Multi_med_list ;;
1) handle_lock ; install_with_progress gimp ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
2) handle_lock ; install_with_progress shotwell ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
3) handle_lock ; install_with_progress audacity ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
4) handle_lock ; install_with_progress kdenlive ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Multi_med_list ;;
esac
}
############################################################################################
Sec_tools () {
echo -e "[+] Choose: \n
		
		[$RED t   $Color_Off] (Kali Tools - Top 10)\n

	Network:
		[$RED n   $Color_Off] (n0-n10)\n
		[$RED n0  $Color_Off] OpenVas \n
		[$RED n1  $Color_Off] Smbclient & Smbmap \n
		[$RED n2  $Color_Off] Ettercap & Etherape \n
		[$RED n3  $Color_Off] Aircrack-Ng & Wifite & MDK4 \n 
		[$RED n4  $Color_Off] Netsniff-ng & Yersinia \n
		[$RED n5  $Color_Off] OpenSSH & Netcat & Socat \n 
		[$RED n6  $Color_Off] Ssldump & Sslsniff & Mitmproxy \n
		[$RED n7  $Color_Off] GoldenEye & Slowhttptest & Hping3 \n 
		[$RED n8  $Color_Off] Nmap & Masscan & Zmap & Netdiscover \n
		[$RED n0  $Color_Off] Wireshark & Tshark & Tcpdump & Ngrep \n
		[$RED n10  $Color_Off] Dsniff & Dnsenum & Dnsmap & Dnstracer \n
		
	Forensic:
		[$RED f  $Color_Off] (f0-f9)\n
		[$RED f0 $Color_Off] Forensics All \t [$RED f1 $Color_Off] Exiftool \n
		[$RED f2 $Color_Off] Binwalk \t\t [$RED f3 $Color_Off] Foremost \n
		[$RED f4 $Color_Off] Steghide \t [$RED f5 $Color_Off] Visualvm \n
		[$RED f6 $Color_Off] Chkrootkit \t [$RED f7 $Color_Off] Rkhunter \n
		[$RED f8 $Color_Off] Unhide \t\t [$RED f9 $Color_Off] Forensics Extra \n
	Web:
		[$RED w  $Color_Off] (w0-w8)\n
		[$RED w0 $Color_Off] Sqlmap \t\t [$RED w1 $Color_Off] Wafw00f \n
		[$RED w2 $Color_Off] Nikto \t\t [$RED w3 $Color_Off] Httrack \n
		[$RED w4 $Color_Off] Gobuster \t [$RED w5 $Color_Off] Wapiti \n
		[$RED w6 $Color_Off] DnsRecon \t [$RED w7 $Color_Off] Dirb & Wfuzz \n
		[$RED w8 $Color_Off] Sublist3r \n
	Crack:
		[$RED c  $Color_Off] (c0-c5)\n
		[$RED c0 $Color_Off] Hashcat \t\t [$RED c1 $Color_Off] John The Ripper\n
		[$RED c2 $Color_Off] Hydra \t\t [$RED c3 $Color_Off] Cewl\n
		[$RED c4 $Color_Off] Crunch \t\t [$RED c5 $Color_Off] Rarcrack & Fcrackzip \n
	OSINT:
		[$RED o  $Color_Off] (o0-o8)\n
		[$RED o0 $Color_Off] Spiderfoot \t [$RED o1 $Color_Off] Maltego \n
		[$RED o2 $Color_Off] Recon-ng \t [$RED o3 $Color_Off] Whois \n 
		[$RED o4 $Color_Off] Cloud-enum \t [$RED o5 $Color_Off] Email2PhoneNumber \n
		[$RED o6 $Color_Off] Hosthunter \t [$RED o7 $Color_Off] Photon \n
		[$RED o8 $Color_Off] TheHarvester \n
	Extra: 
		[$RED e  $Color_Off] (e0-e22 except e6 and e6o)\n
		[$RED e0 $Color_Off] Yara \t\t [$RED e1 $Color_Off] Apktool \n
		[$RED e2 $Color_Off] TOR \t\t [$RED e3 $Color_Off] I2P \n
		[$RED e4 $Color_Off] Gnupg \t\t [$RED e5 $Color_Off] edb Debugger \n
		[$RED e6 $Color_Off] Metasploit \t [$RED e7 $Color_Off] plasma \n
		[$RED e8 $Color_Off] nasm \t\t [$RED e9 $Color_Off] radare2 \n
		[$RED e10 $Color_Off] awscli \t\t [$RED e11 $Color_Off] mimikatz \n
		[$RED e12 $Color_Off] bloodhound \t [$RED e13 $Color_Off] slurp \n
		[$RED e14 $Color_Off] weevely \t [$RED e15 $Color_Off] gdb \n
		[$RED e16 $Color_Off] ollydbg \t [$RED e17 $Color_Off] de4dot \n
		[$RED e18 $Color_Off] chkrootkit \t [$RED e19 $Color_Off] rkhunter \n
		[$RED e20 $Color_Off] porxychains \t [$RED e21 $Color_Off] seclists \n
		[$RED e22 $Color_Off] kali-anonsurf \t [$RED e6o $Color_Off] Metasploit (Using apt) \n\n

		[$RED b  $Color_Off]  Back\n"
read -p "[!] Your choice: " choice
case $choice in
t) handle_lock ; install_with_progress kali-tools-top10 ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

n) handle_lock ; install_with_progress nmap masscan zmap smbclient smbmap netdiscover ettercap-text-only etherape netsniff-ng yersinia openssh-server openssh-client hping3 wireshark tshark tcpdump netcat socat ngrep dsniff dnsenum dnsmap dnstracer goldeneye slowhttptest openvas aircrack-ng wifite mdk4 ssldump sslsniff mitmproxy plasma nasm radare2 awscli mimikatz bloodhound slurp weevely gdb ollydbg de4dot chkrootkit rkhunter porxychains seclists kali-anonsurf; sleep 2 ; clear ;Header ; Sec_tools ;;
n0) handle_lock ; install_with_progress openvas ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n1) handle_lock ; install_with_progress smbclient smbmap ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n2) handle_lock ; install_with_progress ettercap-text-only etherape ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n3) handle_lock ; install_with_progress netsniff-ng yersinia ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n4) handle_lock ; install_with_progress aircrack-ng wifite mdk4 ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n5) handle_lock ; install_with_progress openssh-server openssh-client netcat socat ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n6) handle_lock ; install_with_progress ssldump sslsniff mitmproxy ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n7) handle_lock ; install_with_progress goldeneye slowhttptest hping3 ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n8) handle_lock ; install_with_progress nmap masscan zmap netdiscover ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n9) handle_lock ; install_with_progress wireshark tshark tcpdump ngrep ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n10) handle_lock ; install_with_progress dsniff dnsenum dnsmap dnstracer ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

f) handle_lock ; install_with_progress forensics-all exiftool binwalk foremost steghide visualvm chkrootkit rkhunter unhide forensics-extra; sleep 2 ; clear ; Header ; Sec_tools ;;
f0) handle_lock ; install_with_progress forensics-all ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f1) handle_lock ; install_with_progress exiftool ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f2) handle_lock ; install_with_progress binwalk ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f3) handle_lock ; install_with_progress foremost ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f4) handle_lock ; install_with_progress steghide ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f5) handle_lock ; install_with_progress visualvm ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f6) handle_lock ; install_with_progress chkrootkit ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f7) handle_lock ; install_with_progress rkhunter ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f8) handle_lock ; install_with_progress unhide ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f9) handle_lock ; install_with_progress forensics-extra ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

w) handle_lock ; install_with_progress sqlmap wafw00f nikto httrack gobuster wapiti dnsrecon dirb wfuzz sublist3r ; sleep 2 ; clear ; Header ; Sec_tools ;;
w0) handle_lock ; install_with_progress sqlmap ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w1) handle_lock ; install_with_progress wafw00f ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w2) handle_lock ; install_with_progress nikto ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w3) handle_lock ; install_with_progress httrack ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w4) handle_lock ; install_with_progress gobuster ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w5) handle_lock ; install_with_progress wapiti ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w6) handle_lock ; install_with_progress dnsrecon ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w7) handle_lock ; install_with_progress dirb wfuzz ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w8) handle_lock ; install_with_progress sublist3r ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

c) handle_lock ; install_with_progress hashcat john hydra cewl crunch rarcrack fcrackzip ; sleep 2 ; clear ; Header ; Sec_tools ;;
c0) handle_lock ; install_with_progress hashcat ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c1) handle_lock ; install_with_progress john ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c2) handle_lock ; install_with_progress hydra ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c3) handle_lock ; install_with_progress cewl ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c4) handle_lock ; install_with_progress crunch ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c5) handle_lock ; install_with_progress rarcrack fcrackzip ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

o) handle_lock ; install_with_progress spiderfoot maltego recon-ng whois cloud-enum email2phonenumber hosthunter photon theharvester ; sleep 2 ; clear ; Header ; Sec_tools ;;
o0) handle_lock ; install_with_progress spiderfoot ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o1) handle_lock ; install_with_progress maltego ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o2) handle_lock ; install_with_progress recon-ng ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o3) handle_lock ; install_with_progress whois ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o4) handle_lock ; install_with_progress cloud-enum ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o5) handle_lock ; install_with_progress email2phonenumber ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o6) handle_lock ; install_with_progress hosthunter ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o7) handle_lock ; install_with_progress photon ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o8) handle_lock ; install_with_progress theharvester ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

e) handle_lock ; install_with_progress yara apktool tor i2p gnupg edb-debugger ; sleep 2 ; clear ; Header ; Sec_tools ;;
e0) handle_lock ; install_with_progress yara ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e1) handle_lock ; install_with_progress apktool ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e2) handle_lock ; install_with_progress tor ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e3) handle_lock ; install_with_progress i2p ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e4) handle_lock ; install_with_progress gnupg ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e5) handle_lock ; install_with_progress edb-debugger ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e6) handle_lock ; install_with_progress curl apt-transport-https; cd /tmp/
	curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  	chmod 755 msfinstall && \
  	./msfinstall
	sleep 1.4 ;clear ; Header ; Sec_tools ;;
e6o) handle_lock ; install_with_progress metasploit; sleep 1.4 ;clear ; Header ; Sec_tools ;;
e7) handle_lock ; install_with_progress plasma ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e8) handle_lock ; install_with_progress nasm ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e9) handle_lock ; install_with_progress radare2 ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e10) handle_lock ; install_with_progress awscli ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e11) handle_lock ; install_with_progress mimikatz ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e12) handle_lock ; install_with_progress bloodhound ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e13) handle_lock ; install_with_progress slurp ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e14) handle_lock ; install_with_progress weevely ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e15) handle_lock ; install_with_progress gdb ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e16) handle_lock ; install_with_progress ollydbg ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e17) handle_lock ; install_with_progress de4dot ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e18) handle_lock ; install_with_progress chkrootkit ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e19) handle_lock ; install_with_progress rkhunter ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e20) handle_lock ; install_with_progress porxychains ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e21) handle_lock ; install_with_progress seclists ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e22) handle_lock ; install_with_progress kali-anonsurf ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Sec_tools ;;
esac
}
############################################################################################
Extras () {
echo -e "[+] Choose: \n
	Extra
		[$RED a $Color_Off] (1-5)\n
		[$RED 1 $Color_Off] Putty \t\t [$RED 2 $Color_Off] Openvpn\n
		[$RED 3 $Color_Off] Bleachbit \t [$RED 4 $Color_Off] Virtualbox\n
		[$RED 5 $Color_Off] Gnome Tweak Tool \n
		[$RED 6 $Color_Off] VirtualBox Guest Addition \n
		[$RED 7 $Color_Off] VMware Guest Tools \n
	Chatting
		[$RED 8 $Color_Off] Signal \t [Need to add the repository] \n
		[$RED 9 $Color_Off] Telegram \n\n

		[$RED b $Color_Off] Back \n"
read -p "[!] Your choice: " choice
case $choice in
a) handle_lock ; install_with_progress putty openvpn bleachbit virtualbox gnome-tweak-tool ; sleep 2 ; clear ; Header ; Apt_list ;;
1) handle_lock ; install_with_progress putty ; sleep 1.4 ; clear ; Header ; Extras ;;
2) handle_lock ; install_with_progress openvpn ; sleep 1.4 ; clear ;Header ; Extras ;;
3) handle_lock ; install_with_progress bleachbit ; sleep 1.4 ; clear ;Header ; Extras ;;
4) handle_lock ; install_with_progress virtualbox ; sleep 1.4 ; clear ;Header ; Extras ;;
5) handle_lock ; install_with_progress gnome-tweak-tool ; sleep 1.4 ; clear ;Header ; Extras ;;
6) handle_lock ; install_with_progress virtualbox-guest-x11 virtualbox-guest-additions-iso ; sleep 1.4 ; clear ;Header ; Extras ;;
7) handle_lock ; install_with_progress open-vm-tools ; sleep 1.4 ; clear ;Header ; Extras ;;
8) handle_lock ; install_with_progress signal-desktop ; sleep 1.4 ; clear ;Header ; Extras ;;
9) handle_lock ; install_with_progress telegram-desktop ; sleep 1.4 ; clear ;Header ; Extras ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Extras ;;
esac
}
############################################################################################
Pip_list () {
echo -e "[+] Select: \n
		[$RED p $Color_Off] Pip3 \t\t [It must be installed] \n
	AI - ML:
		[$RED 0 $Color_Off] Jupyter Notebook \t  [$RED 1 $Color_Off] Tensorflow \n
		[$RED 2 $Color_Off] Keras \t\t  [$RED 3 $Color_Off] Opencv-python \n
		[$RED 4 $Color_Off] Imutils \t\t  [$RED 5 $Color_Off] Numpy \n
		[$RED 6 $Color_Off] Matplotlib \t  [$RED 7 $Color_Off] Pytesseract \n
		[$RED 8 $Color_Off] Python-docx \t  [$RED 9 $Color_Off] Docx2txt \n
	Security:
		[$RED 10 $Color_Off] Shodan \t\t  [$RED 11 $Color_Off] BadChars \n
		[$RED 12 $Color_Off] Pillow \t\t  [$RED 13 $Color_Off] Requests \n
		[$RED 14 $Color_Off] Scapy \t\t  [$RED 15 $Color_Off] Cryptography \n
		[$RED 16 $Color_Off] Impacket \t  [$RED 15 $Color_Off] scrapy \n\n

		[$RED b  $Color_Off] Back\n"
read -p "[!] Your choice: " choice
case $choice in
p) handle_lock ; install_with_progress python3-pip ; sudo -H pip3 install --upgrade pip ; sleep 1.4 ; clear ; Header ; Pip_list ;;
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
17) pip3 install scrapy ; sleep 1.4 ; clear ;Header ; Pip_list ;;
b) clear ; Header ; Install_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Pip_list ;;
esac
}
############################################################################################
Snap_list () {
echo -e "[+] Select: \n

		[$RED s $Color_Off] Snap  \t  [It must be installed] \n
		[$RED 0 $Color_Off] Discord \t  [$RED 1 $Color_Off] Zoom-client\n
		[$RED 2 $Color_Off] Eclipse \t  [$RED 3 $Color_Off] Apache NetBeans\n
		[$RED 3 $Color_Off] PyCharm \t  [$RED 4 $Color_Off] Atom\n
		[$RED 5 $Color_Off] DrMIPS \t  [$RED 6 $Color_Off] youtube-dl\n\n
		[$RED b $Color_Off] Back\n"
read -p "[!] Your choice: " choice
case $choice in
s) handle_lock ; install_with_progress snap snapd ; systemctl start snapd ; systemctl enable snapd ; sleep 1.4 ; clear ; Header ; Snap_list ;;
0) handle_lock ; install_with_progress libgconf-2-4 libappindicator1 ; snap install discord ; sleep 1.4 ; clear ; Header ; Snap_list ;;
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
############################################################################################
Install_list () {
echo -e "[+] Select the Package Manager:\n
		[$RED 1 $Color_Off] ==> Apt Packages\n
		[$RED 2 $Color_Off] ==> Snap Packages\n
		[$RED 3 $Color_Off] ==> Pip3 Packages\n
		[$RED b $Color_Off] Back\n"
read -p "[!] Your choice: " choice
case $choice in
1) clear ; Header ; Apt_list;;
2) clear ; Header ; Snap_list;;
3) clear ; Header ; Pip_list;;
b) clear ; Header ; main_menu ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Install_list ;;
esac
}
############################################################################################
Upd_Upg_list () {
echo -e "[+] Select: \n
		[$RED 0 $Color_Off] ! Apt  packages ! \n
		[$RED 1 $Color_Off] ! Snap packages ! \n
		[$RED 2 $Color_Off] ! Pip3 packages !\n
		[$RED b $Color_Off] Back\n"
read -p "[!] Your choice: " choice
case $choice in

0) apt -y update ; apt -y full-upgrade ; clear ; Header ; Upd_Upg_list ;;
1) snap refresh ; clear ; Header ; Upd_Upg_list  ;;
2) pip3 install --upgrade pip; pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U ; clear ; Header ; Upd_Upg_list ;;
b) clear ; Header ; main_menu ;;
*) echo -e "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Upd_Upg_list ;;
esac
}

Header
main_menu