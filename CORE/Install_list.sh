Install_list () {
echo -e "\n$LGREEN** Make sure the repositories are updated **\n$Color_Off"
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