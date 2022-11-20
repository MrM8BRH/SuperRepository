Primary_list () {
echo -e "[+] Choose: \n
		[$RED a $Color_Off] (1-7) \n
		[$RED 1 $Color_Off] git & curl & wget \t [$RED 2 $Color_Off] net-tools & ufw & htop \n
		[$RED 3 $Color_Off] build-essential & dpkg \t [$RED 4 $Color_Off] apt-transport-https \n
		[$RED 5 $Color_Off] synaptic & exFAT \t\t [$RED 6 $Color_Off] kernel headers & dkms \n
		[$RED 7 $Color_Off] rar & unrar & engrampa & gzip \n
		

		[$RED b  $Color_Off]  Back \n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in
a) apt install -y git wget curl ufw htop dpkg net-tools build-essential apt-transport-https rar unrar engrampa gzip dkms linux-headers-$(uname -r) synaptic exfat-fuse exfat-utils ; sleep 1.4 ; clear ; Header ; Primary_list ;;
1) apt install -y git curl wget; sleep 1.4 ; clear ; Header ; Primary_list ;;
2) apt install -y net-tools ufw htop ; sleep 1.4 ; clear ; Header ; Primary_list ;;
3) apt install -y build-essential dpkg ; sleep 1.4 ; clear ; Header ; Primary_list ;;
4) apt install -y apt-transport-https; sleep 1.4 ; clear ; Header ; Primary_list ;;
5) apt install -y synaptic exfat-fuse exfat-utils; sleep 1.4 ; clear ; Header ; Primary_list ;;
6) apt install -y linux-headers-$(uname -r) dkms; sleep 1.4 ; clear ; Header ; Primary_list ;;
7) apt install -y rar unrar engrampa gzip; sleep 1.4 ; clear ; Header ; Primary_list ;;

b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Primary_list ;;
esac
}