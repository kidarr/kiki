#!/bin/bash
# SSH-VPN Installation Setup
# By Vinstechmy
# ==================================
clear
red='\e[1;31m'
green='\e[0;32m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m'
echo ""
echo -e "Want To Change Domain ?"
echo -e ""
echo -e " [1] YES"
echo -e " [2] NO"
echo -e ""
read -rp "Select an option [1-2]: " MENU_OPTION
case "${MENU_OPTION}" in
	1)
		make install
		break
		;;
	2)
		exit 0
		;;
	   *)
	echo -e "${Error}Please enter the correct number [1-2] "
    echo ""
    read -n1 -r -p "Press any key to continue..."
    menu
	;;
	esac
clear
echo -e "Please Insert  Your Domain"
read -p "Hostname / Domain: " host
rm -f /var/lib/crot-script/ipvps.conf
rm -f /var/lib/premium-script/ipvps.conf
rm -f /usr/local/etc/xray/domain
clear
echo -e "Please Insert Your Domain Again"
read -p "Hostname / Domain: " host
echo "IP=$host" >> /var/lib/crot-script/ipvps.conf
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
echo "$host" > /usr/local/etc/xray/domain
clear
echo -e "Renew Certificate Started . . . ."
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$(cat /usr/local/etc/xray/domain)
systemctl stop nginx
systemctl stop xray
systemctl stop xray@vlessws
systemctl stop xray@trojanws
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${green}INFO${NC} ] Starting renew cert... "
rm -r /root/.acme.sh
sleep 1 
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --server https://api.buypass.com/acme/directory \
        --register-account  --accountemail vinstechmymultiport@gmail.com
/root/.acme.sh/acme.sh --server https://api.buypass.com/acme/directory --issue -d $domain --standalone -k ec-256			   
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
systemctl restart $Cek
systemctl restart nginx
systemctl restart xray
systemctl restart xray@vlessws
systemctl restart xray@trojanws
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
clear 
neofetch
echo ""