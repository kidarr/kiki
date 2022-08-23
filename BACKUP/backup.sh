#!/bin/bash
# Set-Backup Installation
# By Vinstechmy
# ==================================
clear
IP=$(wget -qO- icanhazip.com);
date=$(date +"%Y-%m-%d")
clear
echo " Enter Your Email To Receive Backup VPS"
read -rp " Email: " -e email
sleep 1
echo ""
echo " Directory Created"
mkdir /root/backup
sleep 1
echo " Start Backup . . . "
clear
cp -r /var/lib/premium-script/ /root/backup/premium-script
cp -r /usr/local/etc/xray /root/backup/xray
cp -r /home/vps/public_html /root/backup/public_html
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "The following is a link to your vps data backup file.

Your VPS IP $IP

$link

If you want to restore data, please enter the link above.

Thank You For Using Our Services" | mail -s "Backup Data" $email
rm -rf /root/backup
rm -r /root/$IP-$date.zip
echo "Done Backup Your VPS Data"
echo "Please Check Your Email"
echo ""
