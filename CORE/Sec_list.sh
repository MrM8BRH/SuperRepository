Sec_tools () {
echo -e "[+] Choose: \n
	Network:
		[$RED n   $Color_Off] (n0-n10)\n
		[$RED n0  $Color_Off] OpenVas \n
		[$RED n1  $Color_Off] Smbclient & Smbmap \n
		[$RED n2  $Color_Off] Ettercap & Etherape \n
		[$RED n3  $Color_Off] Aircrack-Ng & Wifite & MDK4 \n 
		[$RED n4  $Color_Off] Netsniff-ng & Yersinia \n
		[$RED n5  $Color_Off] OpenSSH & Netcat & Socat \n 
		[$RED n6  $Color_Off] Ssldump & Sslsniff & Mitmproxy \n
		[$RED n7  $Color_Off] GoldenEye & Slowhttptest & Hping3 \n 
		[$RED n8  $Color_Off] Nmap & Masscan & Zmap & Netdiscover \n
		[$RED n0  $Color_Off] Wireshark & Tshark & Tcpdump & Ngrep \n
		[$RED n10  $Color_Off] Dsniff & Dnsenum & Dnsmap & Dnstracer \n
		
	Forensic:
		[$RED f  $Color_Off] (f0-f9)\n
		[$RED f0 $Color_Off] Forensics All \t [$RED f1 $Color_Off] Exiftool \n
		[$RED f2 $Color_Off] Binwalk \t\t [$RED f3 $Color_Off] Foremost \n
		[$RED f4 $Color_Off] Steghide \t [$RED f5 $Color_Off] Visualvm \n
		[$RED f6 $Color_Off] Chkrootkit \t [$RED f7 $Color_Off] Rkhunter \n
		[$RED f8 $Color_Off] Unhide \t\t [$RED f9 $Color_Off] Forensics Extra \n
	Web:
		[$RED w  $Color_Off] (w0-w8)\n
		[$RED w0 $Color_Off] Sqlmap \t\t [$RED w1 $Color_Off] Wafw00f \n
		[$RED w2 $Color_Off] Nikto \t\t [$RED w3 $Color_Off] Httrack \n
		[$RED w4 $Color_Off] Gobuster \t [$RED w5 $Color_Off] Wapiti \n
		[$RED w6 $Color_Off] DnsRecon \t [$RED w7 $Color_Off] Dirb & Wfuzz \n
		[$RED w8 $Color_Off] Sublist3r \n
	Crack:
		[$RED c  $Color_Off] (c0-c5)\n
		[$RED c0 $Color_Off] Hashcat \t\t [$RED c1 $Color_Off] John The Ripper\n
		[$RED c2 $Color_Off] Hydra \t\t [$RED c3 $Color_Off] Cewl\n
		[$RED c4 $Color_Off] Crunch \t\t [$RED c5 $Color_Off] Rarcrack & Fcrackzip \n
	OSINT:
		[$RED o  $Color_Off] (o0-o8)\n
		[$RED o0 $Color_Off] Spiderfoot \t [$RED o1 $Color_Off] Maltego \n
		[$RED o2 $Color_Off] Recon-ng \t [$RED o3 $Color_Off] Whois \n 
		[$RED o4 $Color_Off] Cloud-enum \t [$RED o5 $Color_Off] Email2PhoneNumber \n
		[$RED o6 $Color_Off] Hosthunter \t [$RED o7 $Color_Off] Photon \n
		[$RED o8 $Color_Off] TheHarvester \n
	Extra: 
		[$RED e  $Color_Off] (e0-e22 except e6)\n
		[$RED e0 $Color_Off] Yara \t\t [$RED e1 $Color_Off] Apktool \n
		[$RED e2 $Color_Off] TOR \t\t [$RED e3 $Color_Off] I2P \n
		[$RED e4 $Color_Off] Gnupg \t\t [$RED e5 $Color_Off] edb Debugger \n
		[$RED e6 $Color_Off] Metasploit \t [$RED e7 $Color_Off] plasma \n
		[$RED e8 $Color_Off] nasm \t\t [$RED e9 $Color_Off] radare2 \n
		[$RED e10 $Color_Off] awscli \t\t [$RED e11 $Color_Off] mimikatz \n
		[$RED e12 $Color_Off] bloodhound \t [$RED e13 $Color_Off] slurp \n
		[$RED e14 $Color_Off] weevely \t [$RED e15 $Color_Off] gdb \n
		[$RED e16 $Color_Off] ollydbg \t [$RED e17 $Color_Off] de4dot \n
		[$RED e18 $Color_Off] chkrootkit \t [$RED e19 $Color_Off] rkhunter \n
		[$RED e20 $Color_Off] porxychains \t [$RED e21 $Color_Off] seclists \n
		[$RED e22 $Color_Off] kali-anonsurf \n\n

		[$RED b  $Color_Off]  Back\n"
read -p "[!] Your choice: " choice
case $choice in
n) apt install -y nmap masscan zmap smbclient smbmap netdiscover ettercap-text-only etherape netsniff-ng yersinia openssh-server openssh-client hping3 wireshark tshark tcpdump netcat socat ngrep dsniff dnsenum dnsmap dnstracer goldeneye slowhttptest openvas aircrack-ng wifite mdk4 ssldump sslsniff mitmproxy plasma nasm radare2 awscli mimikatz bloodhound slurp weevely gdb ollydbg de4dot chkrootkit rkhunter porxychains seclists kali-anonsurf; sleep 2 ; clear ;Header ; Sec_tools ;;
n0) apt install -y openvas ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n1) apt install -y smbclient smbmap ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n2) apt install -y ettercap-text-only etherape ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n3) apt install -y netsniff-ng yersinia ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n4) apt install -y aircrack-ng wifite mdk4 ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n5) apt install -y openssh-server openssh-client netcat socat ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n6) apt install -y ssldump sslsniff mitmproxy ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n7) apt install -y goldeneye slowhttptest hping3 ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n8) apt install -y nmap masscan zmap netdiscover ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n9) apt install -y wireshark tshark tcpdump ngrep ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
n10) apt install -y dsniff dnsenum dnsmap dnstracer ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

f) apt install -y forensics-all exiftool binwalk foremost steghide visualvm chkrootkit rkhunter unhide forensics-extra; sleep 2 ; clear ; Header ; Sec_tools ;;
f0) apt install -y forensics-all ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f1) apt install -y exiftool ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f2) apt install -y binwalk ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f3) apt install -y foremost ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f4) apt install -y steghide ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f5) apt install -y visualvm ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f6) apt install -y chkrootkit ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f7) apt install -y rkhunter ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f8) apt install -y unhide ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
f9) apt install -y forensics-extra ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

w) apt install -y sqlmap wafw00f nikto httrack gobuster wapiti dnsrecon dirb wfuzz sublist3r ; sleep 2 ; clear ; Header ; Sec_tools ;;
w0) apt install -y sqlmap ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w1) apt install -y wafw00f ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w2) apt install -y nikto ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w3) apt install -y httrack ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w4) apt install -y gobuster ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w5) apt install -y wapiti ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w6) apt install -y dnsrecon ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w7) apt install -y dirb wfuzz ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
w8) apt install -y sublist3r ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

c) apt install -y hashcat john hydra cewl crunch rarcrack fcrackzip ; sleep 2 ; clear ; Header ; Sec_tools ;;
c0) apt install -y hashcat ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c1) apt install -y john ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c2) apt install -y hydra ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c3) apt install -y cewl ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c4) apt install -y crunch ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
c5) apt install -y rarcrack fcrackzip ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

o) apt install -y spiderfoot maltego recon-ng whois cloud-enum email2phonenumber hosthunter photon theharvester ; sleep 2 ; clear ; Header ; Sec_tools ;;
o0) apt install -y spiderfoot ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o1) apt install -y maltego ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o2) apt install -y recon-ng ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o3) apt install -y whois ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o4) apt install -y cloud-enum ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o5) apt install -y email2phonenumber ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o6) apt install -y hosthunter ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o7) apt install -y photon ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
o8) apt install -y theharvester ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

e) apt install -y yara apktool tor i2p gnupg edb-debugger ; sleep 2 ; clear ; Header ; Sec_tools ;;
e0) apt install -y yara ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e1) apt install -y apktool ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e2) apt install -y tor ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e3) apt install -y i2p ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e4) apt install -y gnupg ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e5) apt install -y edb-debugger ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e6) apt install -y curl apt-transport-https; cd /tmp/
	curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  	chmod 755 msfinstall && \
  	./msfinstall
	sleep 1.4 ;clear ; Header ; Sec_tools ;;
e7) apt install -y plasma ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e8) apt install -y nasm ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e9) apt install -y radare2 ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e10) apt install -y awscli ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e11) apt install -y mimikatz ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e12) apt install -y bloodhound ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e13) apt install -y slurp ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e14) apt install -y weevely ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e15) apt install -y gdb ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e16) apt install -y ollydbg ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e17) apt install -y de4dot ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e18) apt install -y chkrootkit ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e19) apt install -y rkhunter ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e20) apt install -y porxychains ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e21) apt install -y seclists ; sleep 1.4 ; clear ; Header ; Sec_tools ;;
e22) apt install -y kali-anonsurf ; sleep 1.4 ; clear ; Header ; Sec_tools ;;

b) clear ; Header ; Apt_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Sec_tools ;;
esac
}
