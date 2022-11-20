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

0) apt install -y vlc ; sleep 1.4 ; clear ; Header ; Multi_med_list ;;
1) apt install -y gimp ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
2) apt install -y shotwell ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
3) apt install -y audacity ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
4) apt install -y kdenlive ; sleep 1.4 ; clear ;Header ; Multi_med_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Multi_med_list ;;
esac
}