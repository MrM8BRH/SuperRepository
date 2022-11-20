Extras () {
echo -e "[+] Choose: \n
		[$RED a $Color_Off] (1-5)\n
		[$RED 1 $Color_Off] Putty \t\t [$RED 2 $Color_Off] Openvpn\n
		[$RED 3 $Color_Off] Bleachbit \t [$RED 4 $Color_Off] Virtualbox\n
		[$RED 5 $Color_Off] Gnome Tweak Tool \n
		-------
		[$RED 6 $Color_Off] VirtualBox Guest Addition \n
		[$RED 7 $Color_Off] VMware Guest Tools \n
	Chatting
		[$RED 8 $Color_Off] Signal \t [Need to add the repository] \n
		[$RED 9 $Color_Off] Telegram \n\n

		[$RED b $Color_Off] Back \n"
read -p "[!] Your choice: " choice
case $choice in
a) apt install -y putty openvpn bleachbit virtualbox gnome-tweak-tool ; sleep 2 ; clear ; Header ; Apt_list ;;
1) apt install -y putty ; sleep 1.4 ; clear ; Header ; Extras ;;
2) apt install -y openvpn ; sleep 1.4 ; clear ;Header ; Extras ;;
3) apt install -y bleachbit ; sleep 1.4 ; clear ;Header ; Extras ;;
4) apt install -y virtualbox ; sleep 1.4 ; clear ;Header ; Extras ;;
5) apt install -y gnome-tweak-tool ; sleep 1.4 ; clear ;Header ; Extras ;;
6) apt install -y virtualbox-guest-x11 virtualbox-guest-additions-iso ; sleep 1.4 ; clear ;Header ; Extras ;;
7) apt install -y open-vm-tools ; sleep 1.4 ; clear ;Header ; Extras ;;
8) apt install -y signal-desktop ; sleep 1.4 ; clear ;Header ; Extras ;;
9) apt install -y telegram-desktop ; sleep 1.4 ; clear ;Header ; Extras ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Extras ;;
esac
}