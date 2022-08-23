#!/bin/bash
# Script By Vinstechmy
red='\e[1;31m'
green='\e[0;32m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m'
clear
echo -e ""
echo -e  "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m              SYSTEM STATUS                 \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
echo ""
status="$(systemctl show cron.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Cron				: "$green"Running"$NC""
else
echo -e " Cron				: "$red"Not Running (Error)"$NC""
fi

status="$(systemctl show fail2ban.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " Fail2ban			: "$green"Running"$NC""
else
echo -e " Fail2ban			: "$red"Not Running (Error)"$NC""
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " XRAY Vmess TLS			: "$green"Running"$NC""
else
echo -e " XRAY Vmess TLS			: "$red"Not Running (Error)"$NC""
fi

status="$(systemctl show xray.service --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " XRAY Vmess None TLS		: "$green"Running"$NC""
else
echo -e " XRAY Vmess None TLS		: "$red"Not Running (Error)"$NC""
fi

status="$(systemctl show xray@vlessws --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " XRAY Vless TLS			: "$green"Running"$NC""
else
echo -e " XRAY Vless TLS			: "$red"Not Running (Error)"$NC""
fi

status="$(systemctl show xray@vlessws --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " XRAY Vless None TLS		: "$green"Running"$NC""
else
echo -e " XRAY Vless None TLS		: "$red"Not Running (Error)"$NC""
fi

status="$(systemctl show xray@trojanws --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " XRAY Trojan TLS		: "$green"Running"$NC""
else
echo -e " XRAY Trojan TLS		: "$red"Not Running (Error)"$NC""
fi

status="$(systemctl show xray@trojanws --no-page)"
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
if [ "${status_text}" == "active" ]
then
echo -e " XRAY Trojan None TLS		: "$green"Running"$NC""
else
echo -e " XRAY Trojan None TLS		: "$red"Not Running (Error)"$NC""
fi

echo ""