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

0) apt install -y spyder3 ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
1) apt install -y netbeans ; sleep 1.4 ; clear ; Header ; edit_ide_list ;;
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