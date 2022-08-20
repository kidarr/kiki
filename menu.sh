#!/bin/bash
clear
domain=$(cat /etc/xray/domain)
# // Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"

# // Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"

# // Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"

echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 INFO SERVER                \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
IPVPS=$(curl -s ipinfo.io/ip )
if [ "$cekup" = "day" ]; then
echo -e " System Uptime   :  $uphours $upminutes $uptimecek"
else
echo -e " System Uptime   :  $uphours $upminutes"
fi
echo -e " VPN Core        :  XRAY-Core"
echo -e " Current Domain  :  $domain"
echo -e " IP VPS          :  $IPVPS"
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e "\e[33m Traffic\e[0m       \e[33mToday      Yesterday     Month   "
echo -e "\e[33m Download\e[0m      $dtoday    $dyest    $dmon   \e[0m"
echo -e "\e[33m Upload\e[0m        $utoday    $uyest    $umon   \e[0m"
echo -e "\e[33m Total\e[0m       \033[0;36m  $ttoday    $tyest       $tmon  \e[0m "
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 XRAY MENU                  \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m
 [\033[1;36m•1 \033[0m]  Add Vmess Account
 [\033[1;36m•2 \033[0m]  Add Vless Account
 [\033[1;36m•3 \033[0m]  Add Trojan Account
 [\033[1;36m•4 \033[0m]  Cek User XRAY
 [\033[1;36m•5 \033[0m]  Delete User Vmess
 [\033[1;36m•6 \033[0m]  Delete User Vless
 [\033[1;36m•7 \033[0m]  Delete User Trojan
 [\033[1;36m•8 \033[0m]  Renew User Vmess
 [\033[1;36m•9 \033[0m]  Renew User Vless
 [\033[1;36m•10\033[0m]  Renew User Trojan"
echo -e  "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                SYSTEM MENU                 \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m
 [\033[1;36m•11\033[0m]  Change Domain
 [\033[1;36m•12\033[0m]  Renew Certificate XRAY
 [\033[1;36m•13\033[0m]  Check VPN Status
 [\033[1;36m•14\033[0m]  Check VPN Port
 [\033[1;36m•15\033[0m]  Restart VPN Services
 [\033[1;36m•16\033[0m]  Speedtest VPS
 [\033[1;36m•17\033[0m]  Check RAM
 [\033[1;36m•18\033[0m]  Backup
 [\033[1;36m•19\033[0m]  Restore
"
echo -e "\033[1;37mPress [ Ctrl+C ] • To-Exit-Script\033[0m"
echo ""
echo -e "\e[36m╒═════════════════════════════════════════════╕\033[0m"
echo -e " Version       :\033[1;36m Multiport Websocket\e[0m"
echo -e " Provided By   : Vinstechmy"
echo -e " Expiry script : Lifetime"
echo -e "\e[36m╘═════════════════════════════════════════════╛\033[0m"
echo
echo -ne "Select menu : "; read x
if [[ $(cat /opt/.ver) = $serverV ]] > /dev/null 2>&1; then
    if [[ $x -eq 1 ]]; then
       add-ws
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 2 ]]; then
       add-vless
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 3 ]]; then
       add-tr
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 4 ]]; then
       cek-user
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 5 ]]; then
       del-ws
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 6 ]]; then
       del-vless
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 7 ]]; then
       del-tr
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 8 ]]; then
       renew-ws
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 9 ]]; then
       renew-vless
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 10 ]]; then
       renew-tr
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 11 ]]; then
       add-host
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 12 ]]; then
       certxray
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 13 ]]; then
       status
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 14 ]]; then
       info
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 15 ]]; then
       restart
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 16 ]]; then
       clear
       speedtest
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 17 ]]; then
	   clear
       ram
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 18 ]]; then
       backup
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    elif [[ $x -eq 19 ]]; then
       restore
           echo ""
       read -n1 -r -p " Press any key to continue..."
       menu
    else
       menu
    fi
fi
