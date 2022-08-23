#!/bin/bash
# Script By Vinstechmy
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/vlessws.json | grep '^###' | cut -d ' ' -f 2`);
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;36m     XRAY Vless WS User Login      \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipvless.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep xray | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum1=$(cat /var/log/xray/access2.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jum1" = "$ip" ]]; then
echo "$jum1" >> /tmp/ipvless.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum3=$(cat /tmp/ipvless.txt)
sed -i "/$jum3/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvless.txt)
if [[ -z "$jum1" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvless.txt | nl)
echo "User : $akun";
echo "$jum3";
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
fi
rm -rf /tmp/ipvless.txt
done
oth=$(cat /tmp/other.txt | sort | uniq | nl)
echo "Other : ";
echo "$oth";
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
rm -rf /tmp/other.txt
echo ""

