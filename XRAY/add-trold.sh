#!/bin/bash
# SSH-VPN Installation Setup
# By Vinstechmy
# ==================================
clear
domain=$(cat /usr/local/etc/xray/domain)

tr="$(cat ~/log-install.txt | grep -w "TROJAN WS TLS" | cut -d: -f2|sed 's/ //g')"
trnone="$(cat ~/log-install.txt | grep -w "TROJAN WS None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;41;36m           Add XRAY Trojan Account          \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

		read -rp "Username : " -e user
		user_EXISTS=$(grep -w $user /usr/local/etc/xray/trojanws.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		echo -e "\E[0;41;36m           Add XRAY Trojan Account          \E[0m"
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
			menu
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojanws.json
sed -i '/#trojangrpc$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

trojanlink1="trojan://${uuid}@${domain}:${tr}?type=ws&security=tls&host=${domain}&path=/trojanws&sni=bug.com#XRAY_TROJAN_TLS_${user}"
trojanlink2="trojan://${uuid}@${domain}:${tr}?allowInsecure=1&security=tls&type=grpc&serviceName=/trojangrpc&sni=bug.com#XRAY_TROJAN_GRPC_${user}"

systemctl restart xray@trojanws
systemctl restart xray
service cron restart
clear
echo -e ""
echo -e "════════════[XRAY TROJAN ACCOUNT]════════════"
echo -e "Remarks           : ${user}"
echo -e "Domain            : ${domain}"
echo -e "Port TLS          : $tr"
echo -e "Port GRPC         : $tr"
echo -e "ID                : ${uuid}"
echo -e "Security          : TLS"
echo -e "Encryption        : None"
echo -e "Type              : WS & GRPC"
echo -e "Path              : /trojanws"
echo -e "GRPC Path         : /trojangrpc"
echo -e "═════════════════════════════════════════════"
echo -e "Link WS TLS       : ${trojanlink1}"
echo -e "═════════════════════════════════════════════"
echo -e "Link GRPC         : ${trojanlink2}"
echo -e "═════════════════════════════════════════════"
echo -e "Created On        : $hariini"
echo -e "Expired On        : $exp"
echo -e "═════════════════════════════════════════════"
echo -e ""
echo -e "Autoscript By Vinstechmy"
echo -e ""
