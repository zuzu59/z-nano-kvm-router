#!/usr/bin/env bash
#Petit script pour démarrer facilement la fonction routage entre la carte réseau RJ45 et la viruelle USB sur le nano KVM
# Utilisation: bash start-router.sh
#zf260211.1735



# Activer le forwarding IP
sysctl -w net.ipv4.ip_forward=1

# Autoriser le trafic de retour (déjà établi)
iptables -A FORWARD -i eth0 -o usb0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Autoriser le trafic sortant de la carte locale vers Internet
iptables -A FORWARD -i usb0 -o eth0 -j ACCEPT

# Activer le Masquerade sur l'interface Internet
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE



# Récupère l'adresse ip de la carte usb0
USB_IP=$(ip -4 addr show usb0 | awk '/inet / {split($2,a,"/"); print a[1]}')

# Modification de la config du dhcp server
cat /etc/udhcpd.usb0.conf > /tmp/udhcpd.tmp
echo "opt router $USB_IP" >> /tmp/udhcpd.tmp
echo "opt dns 8.8.8.8" >> /tmp/udhcpd.tmp

# Redémarrage du dhcp server
killall udhcpd
udhcpd -S /tmp/udhcpd.tmp &

echo -e "

Routage opérationnel.
Vous devez refaire la connexion usb0 sur la machine remote afin de mette à jour 
l'adresse du default gateway et du DNS

"

