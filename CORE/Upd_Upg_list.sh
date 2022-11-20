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