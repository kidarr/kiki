#!/bin/bash
# SSH-VPN Installation Setup
# By Vinstechmy
# ==================================
clear
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
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
rm -f /etc/xray/domain
rm -r /root/.acme.sh
clear
mkdir /etc/xray
mkdir /var/lib/premium-script;
mkdir /var/lib/crot-script;
clear
echo -e "Please Insert Your Domain Again"
read -p "Hostname / Domain: " host
echo "IP=$host" >> /var/lib/crot-script/ipvps.conf
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
echo "$host" > /etc/xray/domain
clear
echo -e "Renew Certificate Started . . . ."
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$(cat /etc/xray/domain)
systemctl stop nginx
systemctl stop xray.service
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
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --server https://api.buypass.com/acme/directory \
        --register-account  --accountemail wadapap.work@gmail.com
/root/.acme.sh/acme.sh --server https://api.buypass.com/acme/directory --issue -d $domain --standalone -k ec-256			   
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
systemctl restart $Cek
systemctl restart nginx
systemctl start xray.service
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
clear 
neofetch
echo ""

