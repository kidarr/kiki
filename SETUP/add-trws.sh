#!/bin/bash
# Script By Vinstechmy
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo "Autoscript By Vinstechmy"
echo ""
domain=$(cat /usr/local/etc/xray/domain)
tls="$(cat ~/log-install.txt | grep -w "TROJAN WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "TROJAN WS None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/trojanws.json | wc -l)

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
sed -i '/#trws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojanws.json
sed -i '/#trnone$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trnone.json
trojanlink1="trojan://${uuid}@${domain}:$tls?type=ws&security=tls&host=${domain}&path=/trojanws&sni=bug.com#TROJAN_TLS_${user}"
trojanlink2="trojan://${uuid}@${domain}:$none?type=ws&security=none&host=${domain}&path=/trojanws#TROJAN_NON_TLS_${user}"
systemctl restart xray@trojanws
systemctl restart xray@trnone
service cron restart
clear
echo -e ""
echo -e "════════════[XRAY TROJAN WS]════════════"
echo -e "Remarks           : ${user}"
echo -e "Domain            : ${domain}"
echo -e "Port TLS          : $tls"
echo -e "Port none TLS     : $none"
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
