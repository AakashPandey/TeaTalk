#!/bin/bash


fuser -k -n tcp 31313 
fuser -k -n tcp 31312
rm /tmp/.x.txt
clear


usern="$(whoami)"
#yourip="$(ifconfig wlan0 | grep "inet " | awk -F'[: ]+' '{ print $4 }')"
yourip="$(hostname -I)"
usern="$(whoami)"
cd /home/$usern/.ttalk/




banner(){
	
	tput bold && tput setaf 2 && printf "\n%s\n" " T - T A L K"  | awk '{ z = '$(tput cols)' - length; y = int(z / 2); x = z - y; printf "%*s%s%*s\n", x, "", $0, y, ""; }' 
	tput sgr0
	tput setaf 15 && printf "\n%s\n" " Y"  | awk '{ z = '$(tput cols)' - length; y = int(z / 2); x = z - y; printf "%*s%s%*s\n", x, "", $0, y, ""; }' 
	tput sgr0
	printf "\n"
}


menu(){

	tput bold && printf "\n\n%s" ":MENU:" && printf "\n"
	tput sgr0
	tput setaf 15 && printf "\n1.New link\n2.Connect to previous IP\n3.IP History" && printf "\n"
	tput sgr0
	printf "\n"
	read -p "Enter your choice(1-2-3): " choice
	
	if [[ "$choice" == 1 ]]; then
		#statements
		startscr
	fi

	if [[ "$choice" == 2 ]]; then
		
		theirip="$(tail -n 1 .iphist.dat | awk '{print $3}')"
		theirnick="$(tail -n 1 .iphist.dat | awk '{print $1}')"
		
		ipfound="$(echo $theirip | grep -c "192." )"
			if [[ "$ipfound" != 1 ]]; then
				
			printf "No IPs found \nPlease restart with new link\n"
			exit

			fi

	fi

	if [[ "$choice" == 3 ]]; then
		printf "\n"
		tput bold && echo :IP History: && tput sgr0
		printf "\n"
		tput setaf 4 && grep -n '.' .iphist.dat >> .iplist.dat && cat .iplist.dat && rm .iplist.dat 
		tput sgr0
		printf "\n"
		ips="$(grep -c '192.' .iphist.dat)"
		
		read -p "Enter choice (1-$ips): " ipch
		
		if [[ -n ${ipch//[1-9]/} || "$ipch" > "$ips" ]]; then   
			echo incorrect choice && exit
		fi

        theirip="$(awk 'NR=='$ipch'' .iphist.dat | awk '{print $3}')"
		theirnick="$(awk 'NR=='$ipch'' .iphist.dat | awk '{print $1}')"



		printf "\n"
		

	fi
	
	if [[ "$choice" != 1 && "$choice" != 2 && "$choice" != 3 ]]; then
		echo incorrect choice
		exit
		
	fi
}

startscr(){
	tput bold
	tput setaf 15 && printf "\nShare your ip with the partner - %s" "$yourip" && tput sgr0
	printf "\n"
	tput setaf 6 && read -p "Enter partner's ip : " theirip
	tput setaf 6 && read -p "Enter a nickname for $theirip : " theirnick
	echo "$theirnick - $theirip" >> .iphist.dat														
	tput setaf 15 && printf "\n%s" "Type BYE to end chat" 
	printf "\n"
	printf "\n"
	tput setaf 15 && read -p "Press Enter to begin" 
	clear
    


}

take(){
	stty echo 
	printf "\n"
  	tput setaf 2 && read -p "$usern: " msg
  	

}

send(){

	echo $usern: $msg | nc $theirip 31313 

}



listen(){
    stty -echo
    nc -l -p 31312 >> /tmp/.x.txt
    out="$(tail -n 1 /tmp/.x.txt)"
    tput setaf 3 && printf "\n\t\t\t$out"
    printf "\n"
    stty -echo

}

BYE(){

	chkBYE="$(tail -n 1 /tmp/.x.txt | awk '{print $2}')"
  	if [ "$chkBYE" == "left" ]; then
  		a=1
	fi
	
}


banner

menu

tput bold && echo "You are now conncted to $theirnick at $theirip" && tput sgr0		
echo "Waiting for first message..."
printf "\n"

while [ "$msg" != "BYE" ]; do

	listen

	BYE

				
		if [ "$a" == 1 ]; then

			 printf "\n"  
			 stty echo
			 tput setaf 1 && echo chat ended 
			 tput sgr0
			 printf "\n"
			 cd
			 break
			 
		
		fi    

	take
	 
	    if [ "$msg" == "" ]; then
             tput setaf 2 && read -p "$usern: " msg
        fi 
   
        if [ "$msg" == "BYE" ]; then
              echo $usern left the chat | nc $theirip 31313
              tput setaf 1 && echo chat ended 
              stty echo
              cd
              break
        fi
	

	send	
		
done		
