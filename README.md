# Petit script tout simple pour démarrer le routage entre les cartes réseau RJ45 et USB0 sur un nano KVM
zf260211.1514

L'utilisation du nano KVM est une petite merveille !

https://github.com/sipeed/NanoKVM

En fait ce n'est pas qu'un simple KVM (Keyboard, Video, Mouse) mais un KVMNC  !

Il faut office de

* Keyboard, émultation du clavier dans un browser
* Vidéo, émultation d'un moniteur HDMI TV dans un browser
* Mouse, émulation d'une souris dans un browser
* Network, émulation d'une carte réseau USB sur l'ordinateur remote
* CDROM, émultation d'un CDROM sur 'ordinateur remote

Mais quand on utilise, sur l'ordinateur remote où est branché le nano KVM (via la prise USB), l'émulation de la carte réseau n'est *connectée* que entre le nano KVM et l'ordinateur remote.<br>
Il n'y a pas de connexion avec le réseau local ou Internet !

Pour avoir cette *connexion* il faut configurer la fonction *routage* entre les deux cartes réseau sur le nano KVM.

On peut le faire très facilement avec le petit script bash *start-router.sh* depuis la *fenêtre* Terminal du nano KVM sur le browser. Le nano KVM est en fait un petit Linux buildroot assez complet.

Mais il manque encore une chose importante pour que cela fonctionne. Malheureusement le DHCP serveur du nano KVM ne distribue pas l'adresse ip du *default gateway* ni celle du *DNS* !<br>
C'est pourquoi à la fin du *routage* dans le scipt il y a la partie correction du DHCP server.

On peut *descendre* le script sur le nano KVM avec l'icone *Script*


