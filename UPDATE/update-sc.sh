#!/bin/bash
# XRAY Core & Trojan-Go Installation Setup
# By Vinstechmy
# ==================================
red='\e[1;31m'
green='\e[0;32m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m'
clear
sleep 1
echo -e "[ ${green}INFO${NC} ] Update New Patch For Autoscript Multiport Websocket "
sleep 1
echo ""
echo -e "[ ${green}INFO${NC} ] Please Wait Update Is Starting . . "
sleep 1

cd
# // REMOVE OLD FILES
rm /usr/bin/add-tr
rm /usr/bin/del-tr
rm /usr/bin/user-tr
rm /usr/bin/add-ws
rm /usr/bin/del-ws
rm /usr/bin/user-ws
rm /usr/bin/add-vless
rm /usr/bin/del-vless
rm /usr/bin/user-vless
rm /usr/bin/add-xray
rm /usr/bin/del-xray
rm /usr/bin/user-xray
rm /usr/bin/add-xtr
rm /usr/bin/del-xtr
rm /usr/bin/user-xtr
rm /usr/bin/add-trgo
rm /usr/bin/del-trgo
rm /usr/bin/user-trgo
rm /usr/bin/xp

cd /usr/bin

# // SSHVPN FILES
wget -O xp https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/SSH/xp.sh && chmod +x xp

# // VMESS WS FILES
wget -O add-ws "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/add-ws.sh" && chmod +x add-ws
wget -O del-ws "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/del-ws.sh" && chmod +x del-ws
wget -O user-ws "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/user-ws.sh" && chmod +x user-ws

# // VLESS WS FILES
wget -O add-vless "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/add-vless.sh" && chmod +x add-vless
wget -O del-vless "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/del-vless.sh" && chmod +x del-vless
wget -O user-vless "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/user-vless.sh" && chmod +x user-vless

# // TROJAN WS FILES
wget -O add-tr "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/add-tr.sh" && chmod +x add-tr
wget -O del-tr "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/del-tr.sh" && chmod +x del-tr
wget -O user-tr "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/user-tr.sh" && chmod +x user-tr

# // VLESS TCP XTLS
wget -O add-xray "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/add-xray.sh" && chmod +x add-xray
wget -O del-xray "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/del-xray.sh" && chmod +x del-xray
wget -O user-xray "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/user-xray.sh" && chmod +x user-xray

# // TROJAN TCP FILES
wget -O add-xtr "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/add-xtr.sh" && chmod +x add-xtr
wget -O del-xtr "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/del-xtr.sh" && chmod +x del-xtr
wget -O user-xtr "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/XRAY/user-xtr.sh" && chmod +x user-xtr


# // TROJAN GO FILES
wget -O add-trgo "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/TRGO/add-trgo.sh" && chmod +x add-trgo
wget -O del-trgo "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/TRGO/del-trgo.sh" && chmod +x del-trgo
wget -O user-trgo "https://raw.githubusercontent.com/vinstechmy/multiport-websocket/main/TRGO/user-trgo.sh" && chmod +x user-trgo


cd
rm -f update.sh
echo -e "[ ${green}INFO${NC} ] Successfully Update Latest Patch ! "
sleep 1
clear
menu