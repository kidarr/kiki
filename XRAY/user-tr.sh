#!/bin/bash
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/etc/xray/trojanws.json")
        if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
                echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo -e "\\E[0;41;36m    Check XRAY Trojan WS Config    \E[0m"
                echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo ""
                echo "You have no existing clients!"
                echo ""
                exit 1
        fi

        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\\E[0;41;36m    Check XRAY Trojan WS Config    \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo " Select the existing client to view the config"
        echo " Press CTRL+C to return"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo "     No  Expired   User"
        grep -E "^### " "/usr/local/etc/xray/trojanws.json" | cut -d ' ' -f 2-3 | nl -s ') '
        until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
                if [[ ${CLIENT_NUMBER} == '1' ]]; then
                        read -rp "Select one client [1]: " CLIENT_NUMBER
                else
                        read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
                fi
        done
        user=$(grep -E "^### " "/usr/local/etc/xray/trojanws.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
tr="$(cat ~/log-install.txt | grep -w "TROJAN WS TLS" | cut -d: -f2|sed 's/ //g')"
trnone="$(cat ~/log-install.txt | grep -w "TROJAN WS None TLS" | cut -d: -f2|sed 's/ //g')"
domain=$(cat /usr/local/etc/xray/domain)
uuid=$(grep "},{" /usr/local/etc/xray/trojanws.json | cut -b 17-52 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/etc/xray/trojanws.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=`date -d "0 days" +"%Y-%m-%d"`
trojanlink1="trojan://${uuid}@${domain}:${tr}?type=ws&security=tls&host=${domain}&path=/trojanws&sni=bug.com#XRAY_TROJAN_TLS_${user}"
trojanlink2="trojan://${uuid}@${domain}:${trnone}?type=ws&security=none&host=${domain}&path=/trojanws#TROJAN_NON_TLS_${user}"
systemctl restart xray@trojanws
service cron restart
clear
echo -e ""
echo -e "════════════[XRAY TROJAN WS]════════════"
echo -e "Remarks           : ${user}"
echo -e "Domain            : ${domain}"
echo -e "Port TLS          : $tr"
echo -e "Port None TLS     : $trnone"
echo -e "ID                : ${uuid}"
echo -e "Security          : TLS"
echo -e "Encryption        : None"
echo -e "Network           : WS"
echo -e "Path              : /trojanws"
echo -e "════════════════════════════════════════"
echo -e "Link WS TLS       : ${trojanlink1}"
echo -e "════════════════════════════════════════"
echo -e "Link WS None TLS  : ${trojanlink2}"
echo -e "════════════════════════════════════════"
echo -e "Created On        : $hariini"
echo -e "Expired On        : $exp"
echo -e "════════════════════════════════════════"
echo -e ""
echo -e "Autoscript By Vinstechmy"
echo -e ""