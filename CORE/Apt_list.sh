Apt_list () {
echo -e "[+] Choose: \n
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