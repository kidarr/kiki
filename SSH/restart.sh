#!/bin/bash
# Script By Vinstechmy
clear
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
systemctl restart xray
systemctl restart nginx
systemctl restart xray@vlessws
systemctl restart xray@trojanws
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;41;36m       All Services Restarted       \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 1
clear
menu
