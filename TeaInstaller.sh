#!/bin/bash
clear
curpath="$(pwd)"
usern="$(whoami)"
tput bold && tput rev && tput setaf 2 && printf "\n%s\n" " T - T A L K"  | awk '{ z = '$(tput cols)' - length; y = int(z / 2); x = z - y; printf "%*s%s%*s\n", x, "", $0, y, ""; }' 
tput sgr0
tput rev && tput setaf 2 && printf "\n%s" "----------------------" | awk '{ z = '$(tput cols)' - length; y = int(z / 2); x = z - y; printf "%*s%s%*s\n", x, "", $0, y, ""; }' 
tput sgr0
tput setaf 15 && printf "\n%s\n" "A Terminal tool for for texting on local WiFi"   | awk '{ z = '$(tput cols)' - length; y = int(z / 2); x = z - y; printf "%*s%s%*s\n", x, "", $0, y, ""; }' 
tput sgr0
tput setaf 15 && printf "\n%s\n" "version 2.0"  | awk '{ z = '$(tput cols)' - length; y = int(z / 2); x = z - y; printf "%*s%s%*s\n", x, "", $0, y, ""; }' 
tput sgr0
tput setaf 2 && printf "\n%s\n" " Created by - Aakash Pandey - aakash.pandey@live.com"  | awk '{ z = '$(tput cols)' - length; y = int(z / 2); x = z - y; printf "%*s%s%*s\n", x, "", $0, y, ""; }' 
tput sgr0
sleep 5 

printf "\n" 
read -p "Press Enter to install "
cd 
mkdir -p .ttalk

printf "\n"

BAR='[▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓░▓]'    
                         

for i in {1..31}; do
    tput setaf 2 && echo -ne "\r${BAR:0:$i}" 
    sleep .3
done

printf "\n"
tput sgr0

echo "alias ttalk='/home/$usern/.ttalk/./.tln'" >> .bashrc


printf "\n%s\n" "Installation completed !"

sleep 3

clear 

cd $curpath
cp -Rvn $curpath/.x /home/$usern/.ttalk/ 2>/dev/null
cp -Rvn $curpath/.y /home/$usern/.ttalk/ 2>/dev/null
cp -Rvn $curpath/.tln /home/$usern/.ttalk/ 2>/dev/null
touch /home/$usern/.ttalk/.iphist.dat

cd



clear

printf "\n%s\n" "Restart Terminal and type "ttalk" to begin" 
printf "\n"
