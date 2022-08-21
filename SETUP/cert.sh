#!/bin/bash
# SSH-VPN Installation Setup
# By Vinstechmy
# ==================================
source /var/lib/premium-script/ipvps.conf
domain=$(cat /usr/local/etc/xray/domain)
clear
echo -e "[ ${green}INFO${NC} ] Start " 
sleep 0.5
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
sleep 2
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --server https://api.buypass.com/acme/directory \
        --register-account  --accountemail vinstechmyproject@gmail.com
/root/.acme.sh/acme.sh --server https://api.buypass.com/acme/directory --issue -d $domain --standalone -k ec-256			   
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Renew cert done... " 
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting service $Cek " 
sleep 2
echo $domain > /usr/local/etc/xray/domain
systemctl restart $Cek
systemctl restart nginx
systemctl start xray.service
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
clear
neofetch
echo ""
