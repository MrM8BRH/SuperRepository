Prog_lan_list () {
echo -e "[+] Choose: \n
		[$RED 0 $Color_Off] Go 1.19.3 \t [You must restart the system after installation]
		[$RED 1 $Color_Off] C++
		
		[$RED 2 $Color_Off] Java 8 
		[$RED 3 $Color_Off] Java 11 
		[$RED 4 $Color_Off] Java 14
		[$RED 5 $Color_Off] Java 17
		
		[$RED 6 $Color_Off] Ruby & Perl
		[$RED 7 $Color_Off] Python3 & python2

		[$RED 8 $Color_Off] PHP & PhpMyAdmin
		[$RED 9 $Color_Off] NodeJS

		[$RED 10 $Color_Off] MySql
		[$RED 11 $Color_Off] Postgresql

		[$RED 12 $Color_Off] Nginx
		[$RED 13 $Color_Off] Apache2 \n\n
		[$RED b  $Color_Off] Back\n$Color_Off"
read -p "[!] Your choice: " choice
case $choice in

0) cd /tmp ; wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz ;
   tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz ;
   echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile ;
   sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
1) apt install -y g++ ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;
2) apt install -y openjdk-8-jre openjdk-8-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
3) apt install -y openjdk-11-jre openjdk-11-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
4) apt install -y openjdk-14-jre openjdk-14-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
5) apt install -y openjdk-17-jre openjdk-17-jdk ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
6) apt install -y ruby perl ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
7) apt install -y python3 python3-pip python2 ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
8) apt install -y php phpmyadmin ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
9) apt install -y nodejs ; sleep 1.4 ; clear ;Header ; Prog_lan_list ;;
10) apt install -y mysql-server mysql-client ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
11) apt install -y postgresql ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
12) apt install -y nginx ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
13) apt install -y apache2 ; sleep 1.4 ; clear ; Header ; Prog_lan_list ;;
b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Prog_lan_list ;;
esac
}