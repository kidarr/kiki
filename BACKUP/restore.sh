#!/bin/bash
# Set-Backup Installation
# By Vinstechmy
# ==================================
clear
echo ""
echo " This Feature Can Only Be Used According To Vps Data With This Autoscript"
echo " Please input link to your vps data backup file."
echo " You can check it on your email if you run backup data vps before."
echo ""
read -rp " Link File: " -e url
wget -O backup.zip "$url"
unzip backup.zip
rm -f backup.zip
sleep 1
echo " Start Restore . . . "
cp -r premium-script /var/lib/
cp -r xray /usr/local/etc/
strt
rm -rf /root/backup
rm -f backup.zip
echo ""
echo -e "[ ${green}INFO${NC} ] Done Restore Your VPS Data " 
sleep 0.5
clear
neofetch
echo ""