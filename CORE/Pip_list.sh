Pip_list () {
echo -e "[+] Select: \n
		[$RED p $Color_Off] Pip3 \t\t [It must be installed] \n
	AI - ML:
		[$RED 0 $Color_Off] Jupyter Notebook \t  [$RED 1 $Color_Off] Tensorflow \n
		[$RED 2 $Color_Off] Keras \t\t  [$RED 3 $Color_Off] Opencv-python \n
		[$RED 4 $Color_Off] Imutils \t\t  [$RED 5 $Color_Off] Numpy \n
		[$RED 6 $Color_Off] Matplotlib \t  [$RED 7 $Color_Off] Pytesseract \n
		[$RED 8 $Color_Off] Python-docx \t  [$RED 9 $Color_Off] Docx2txt \n
	Security:
		[$RED 10 $Color_Off] Shodan \t\t  [$RED 11 $Color_Off] BadChars \n
		[$RED 12 $Color_Off] Pillow \t\t  [$RED 13 $Color_Off] Requests \n
		[$RED 14 $Color_Off] Scapy \t\t  [$RED 15 $Color_Off] Cryptography \n
		[$RED 16 $Color_Off] Impacket \t  [$RED 15 $Color_Off] scrapy \n\n

		[$RED b  $Color_Off] Back\n"
read -p "[!] Your choice: " choice
case $choice in
p) apt install -y python3-pip ; sudo -H pip3 install --upgrade pip ; sleep 1.4 ; clear ; Header ; Pip_list ;;
0) pip3 install notebook ; sleep 1.4 ; clear ; Header ; Pip_list ;;
1) pip3 install tensorflow ; sleep 1.4 ; clear ; Header ; Pip_list ;;
2) pip3 install Keras ; sleep 1.4 ; clear ;Header ; Pip_list ;;
3) pip3 install opencv-python ; sleep 1.4 ; clear ;Header ; Pip_list ;;
4) pip3 install imutils ; sleep 1.4 ; clear ;Header ; Pip_list ;;
5) pip3 install numpy ; sleep 1.4 ; clear ;Header ; Pip_list ;;
6) pip3 install matplotlib ; sleep 1.4 ; clear ;Header ; Pip_list ;;
7) pip3 install pytesseract ; sleep 1.4 ; clear ;Header ; Pip_list ;;
8) pip3 install python-docx ; sleep 1.4 ; clear ;Header ; Pip_list ;;
9) pip3 install docx2txt ; sleep 1.4 ; clear ;Header ; Pip_list ;;
10) pip3 install shodan ; sleep 1.4 ; clear ;Header ; Pip_list ;;
11) pip3 install badchars ; sleep 1.4 ; clear ;Header ; Pip_list ;;
12) pip3 install pillow ; sleep 1.4 ; clear ;Header ; Pip_list ;;
13) pip3 install requests ; sleep 1.4 ; clear ;Header ; Pip_list ;;
14) pip3 install scapy ; sleep 1.4 ; clear ;Header ; Pip_list ;;
15) pip3 install cryptography ; sleep 1.4 ; clear ;Header ; Pip_list ;;
16) pip3 install impacket ; sleep 1.4 ; clear ;Header ; Pip_list ;;
17) pip3 install scrapy ; sleep 1.4 ; clear ;Header ; Pip_list ;;
b) clear ; Header ; Install_list ;;
*) echo "'$choice': is not a valid option"; sleep 2 ; clear ; Header ; Pip_list ;;
esac
}