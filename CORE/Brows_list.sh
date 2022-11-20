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

0) apt install -y brave-browser ; sleep 1.4 ; clear ;Header ; Brows_list ;;
1) apt install -y opera-stable ; sleep 1.4 ; clear ;Header ; Brows_list ;;
2) apt install -y yandex-browser-beta ; sleep 1.4 ; clear ;Header ; Brows_list ;;
3) apt install -y firefox ; sleep 1.4 ; clear ; Header ; Brows_list ;;
4) apt install -y chromium-browser ; sleep 1.4 ; clear ; Header ; Brows_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Brows_list ;;
esac
}