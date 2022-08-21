#!/bin/bash
# Script By Vinstechmy
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo "Autoscript By Vinstechmy"
echo ""
domain=$(cat /usr/local/etc/xray/domain)
tls="$(cat ~/log-install.txt | grep -w "VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "VLESS WS None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vnone.json
vlesslink1="vless://${uuid}@${domain}:$tls?type=ws&encryption=none&security=tls&host=${domain}&path=/vlessws&allowInsecure=1&sni=bug.com#VLESS_TLS_${user}"
vlesslink2="vless://${uuid}@${domain}:$none?type=ws&encryption=none&security=none&host=${domain}&path=/vlessws#VLESS_NON_TLS_${user}"
systemctl restart xray@vless
systemctl restart xray@vnone
service cron restart
clear
echo -e ""
echo -e "════════════[XRAY VLESS WS]════════════"
echo -e "Remarks           : ${user}"
echo -e "Domain            : ${domain}"
echo -e "Port TLS          : $tls"
echo -e "Port none TLS     : $none"
echo -e "ID                : ${uuid}"
echo -e "Security          : TLS"
echo -e "Encryption        : None"
echo -e "Network           : WS"
echo -e "Path              : /vlessws"
echo -e "═══════════════════════════════════════"
echo -e "Link WS TLS       : ${vlesslink1}"
echo -e "═══════════════════════════════════════"
echo -e "Link WS None TLS  : ${vlesslink2}"
echo -e "═══════════════════════════════════════"
echo -e "Created On        : $hariini"
echo -e "Expired On        : $exp"
echo -e "═══════════════════════════════════════"
echo -e ""
echo -e "Autoscript By Vinstechmy"
echo -e ""
