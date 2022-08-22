#!/bin/bash
# SSH-VPN Installation Setup
# By Vinstechmy
# ==================================
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear
domain=$(cat /usr/local/etc/xray/domain)
tls="$(cat ~/log-install.txt | grep -w "VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "VLESS WS None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		echo -e "\E[0;41;36m           Add XRAY Vless Account          \E[0m"
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vlessws.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		echo -e "\E[44;1;39m      Add XRAY Vless Account      \E[0m"
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			read -n 1 -s -r -p "Press any key to back on menu"
			menu
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessws.json
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:$tls?type=ws&encryption=none&security=tls&host=${domain}&path=/vlessws&allowInsecure=1&sni=bug.com#VLESS_TLS_${user}"
vlesslink2="vless://${uuid}@${domain}:$none?type=ws&encryption=none&security=none&host=${domain}&path=/vlessws#VLESS_NON_TLS_${user}"
vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=/vlessgrpc&sni=bug.com#VLESS_GRPC_${user}"
systemctl restart xray@vlessws
systemctl restart xtay@vlessgrpc
service cron restart
clear
echo -e ""
echo -e "════════════[XRAY VLESS ACCOUNT]════════════"
echo -e "Remarks           : ${user}"
echo -e "Domain            : ${domain}"
echo -e "Port TLS          : $tls"
echo -e "Port None TLS     : $none"
echo -e "Port GRPC         : $tls"
echo -e "ID                : ${uuid}"
echo -e "Security          : TLS"
echo -e "Encryption        : None"
echo -e "Type              : WS & GRPC"
echo -e "Path              : /vlessws"
echo -e "GRPC Path         : /vlessgrpc"
echo -e "════════════════════════════════════════════"
echo -e "Link WS TLS       : ${vlesslink1}"
echo -e "════════════════════════════════════════════"
echo -e "Link WS None TLS  : ${vlesslink2}"
echo -e "════════════════════════════════════════════"
echo -e "Link GRPC         : ${vlesslink3}"
echo -e "════════════════════════════════════════════"
echo -e "Created On        : $hariini"
echo -e "Expired On        : $exp"
echo -e "════════════════════════════════════════════"
echo -e ""
echo -e "Autoscript By Vinstechmy"
echo -e ""
