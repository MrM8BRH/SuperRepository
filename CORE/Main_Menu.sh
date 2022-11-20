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

trap ctrl_c INT
ctrl_c() {
clear ; exit ;
}