Repo_list () {
echo -e "[+] Select the Repository:\n
		[$RED i $Color_Off] Install Requirements\n
		[$RED 0 $Color_Off] Signal - Private Messenger\n
		[$RED 1 $Color_Off] Sublime Text\n
		[$RED 2 $Color_Off] Brave Browser\n
		[$RED 3 $Color_Off] Opera Browser\n
		[$RED 4 $Color_Off] Yandex Browser\n
		[$RED 5 $Color_Off] Flatpak\n
		[$RED 6 $Color_Off] Visual Studio Code\n
		[$RED 7 $Color_Off] Graphics drivers (Nvidia)\n\n
		[$RED b $Color_Off] Back\n"
read -p "[!] Your choice: " choice
case $choice in
i)	apt update ; apt install -y curl wget software-properties-common; clear ; Header ; Repo_list ;;

0)	curl -s https://updates.signal.org/desktop/apt/keys.asc | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/signal.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/signal.gpg ;
	echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee -a /etc/apt/sources.list.d/signal-xenial.list ;
	apt update ; clear ; Header ; Repo_list ;;

1)	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/sublime.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/sublime.gpg ;
	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list ;
	apt update ; clear ; Header ; Repo_list ;;

2)	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/brave.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/brave.gpg ;
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list ;
	apt update ; clear ; Header ; Repo_list ;;

3)	wget -qO- https://deb.opera.com/archive.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/opera.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/opera.gpg
	add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free" ;
	apt update ; clear ; Header ; Repo_list ;;

4)	wget -qO-  https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/yandex.gpg --import ;
	chmod 644 /etc/apt/trusted.gpg.d/yandex.gpg ;
	echo "deb [arch=amd64] http://repo.yandex.ru/yandex-browser/deb beta main" > /etc/apt/sources.list.d/yandex-browser-beta.list ;
	apt update ; clear ; Header ; Repo_list ;;

5)	add-apt-repository ppa:flatpak/stable ; apt install flatpak gnome-software-plugin-flatpak ;
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo ; clear ; Header ; Repo_list ;;

6)	cd /tmp/ ; curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg ;
	install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ ; 
	sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' ; sleep 1.4;
	cd -;
	apt update ; clear ; Header ; Repo_list ;;

7)	add-apt-repository ppa:graphics-drivers/ppa ; apt update ; clear ; Header ; Repo_list ;;

b) clear ; Header ; main_menu ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Repo_list ;;
esac
}