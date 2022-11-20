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
s) apt install -y snap snapd ; systemctl start snapd ; systemctl enable snapd ; sleep 1.4 ; clear ; Header ; Snap_list ;;
0) apt install -y libgconf-2-4 libappindicator1 ; snap install discord ; sleep 1.4 ; clear ; Header ; Snap_list ;;
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