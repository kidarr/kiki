#!/bin/bash
# SSH-VPN Installation Setup
# By Vinstechmy
# ==================================
clear
domain=$(cat /usr/local/etc/xray/domain)

tls="$(cat ~/log-install.txt | grep -w "VMESS WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "VMESS WS None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;36m      Add XRAY Vmess Account      \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

                read -rp "Username : " -e user
                CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vmessws.json | wc -l)

                if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		echo -e "\E[0;41;36m           Add XRAY Vmess Account          \E[0m"
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                        echo ""
                        echo "A client with the specified name was already created, please choose another name."
                        echo ""
                        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                        read -n 1 -s -r -p "Press any key to back on menu"
                fi
        done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmessws.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
cat> /usr/local/etc/xray/$user-tls.json << EOF
      {
      "v": "2",
      "ps": "XRAY_VMESS_TLS_${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
cat> /usr/local/etc/xray/$user-none.json << EOF
      {
      "v": "2",
      "ps": "XRAY_VMESS_NON_TLS_${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
cat > /usr/local/etc/xray/$user-tlsgrpc.json << EOF
      {
      "v": "2",
      "ps": "XRAY_VMESS_GRPC_${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "/vmessgrpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"
vmesslink3="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tlsgrpc.json)"
systemctl restart xray
systrmctl restart xray@vmessgrpc
service cron restart
clear
echo -e ""
echo -e "════════════[XRAY VMESS ACCOUNT]════════════"
echo -e "Remarks           : ${user}"
echo -e "Domain            : ${domain}"
echo -e "Port TLS          : ${tls}"
echo -e "Port None TLS     : ${none}"
echo -e "Port GRPC         : ${tls}"
echo -e "ID                : ${uuid}"
echo -e "AlterId           : 0"
echo -e "Security          : Auto"
echo -e "Type              : WS & GRPC"
echo -e "Path              : /vmessws"
echo -e "GRPC Path         : /vmessgrpc"
echo -e "════════════════════════════════════════════"
echo -e "Link WS TLS       : ${vmesslink1}"
echo -e "════════════════════════════════════════════"
echo -e "Link WS None TLS  : ${vmesslink2}"
echo -e "════════════════════════════════════════════"
echo -e "Link GRPC         : ${vmesslink3}"
echo -e "════════════════════════════════════════════"
echo -e "Created On        : $hariini"
echo -e "Expired On        : $exp"
echo -e "════════════════════════════════════════════"
echo -e ""
echo -e "Autoscript By Vinstechmy"
echo -e ""
