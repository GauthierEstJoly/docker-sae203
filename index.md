# SAE 2.03

## Introduction

Pour notre projet, nous avons choisi de créer un serveur de partage de fichiers après avoirdébattu pendantlongtemps.
Ce projet peut paraître simple mais il demande beaucoup de configuration pour marcher, spécialement sur docker.


## Docker
![Docker Logo](images/docker-logo.webp)
Docker est une plateforme permettant de lancer certaines applications dans des conteneurs logiciels.
Docker nous permet de créer une seule application qui marchera sur toutes les machines.
![Docker Architecture](images/architecture.svg)

## Partage de fichier

Il y a plusieurs systèmes de partage de fichiers, tous avec leur utilisation particulière :
- FTP : File Transfer Protocol, ou FTP, est un protocole de communication destiné au partage de fichiers sur un réseau TCP/IP.
- SMB : Server Message Block, ou SMB, est un protocole permettant le partage de ressources sur des réseaux locaux avec des PC sous Windows.
- NFS : Network File System, ou NFS, littéralement système de fichiers en réseau, est à l'origine un protocole développé par Sun Microsystems en 1984 qui permet à un ordinateur d'accéder via un réseau à des fichiers distants.

## FTP

Nous avons choisi FTP car c'est le system le plus simple à implementer et à utiliser.
Il marche par créer une connexion entre le client et le serveur pour transférer les commands, et crée d'autres connectaient pour transférer les données.
![File Transfer Protocol](images/file-transfer-protocol-min.png)

## Creation du Dockerfile

Nous avons pris comme base un Dockerfile d'un TP, et modifié pour marcher avec notre nouvelle configuration.
Nous avons aussi recherché la syntaxe correcte pour notre utilisation sur Google.
Ce Dockerfile install les paquets nécessaires, met en place le fichier de configuration, crée les utilisateurs et expose les ports.

Il a fallu exposer les ports 21 (FTP) mais aussi les ports utiles au transfert de données passives.

## Configuration de ProFTPd

Afin de configurer ProFTPd, nous avons utilisé pour base une configuration trouvée sur Google, puis nous l'avons beaucoup modifier.
Cette configuration détermine une plage de ports passifs, les permissions des utilisateurs, mais aussi des informations du réseau.

### Problemes

Nous avons eu 2 problèmes :
- Problème de permission d'utilisateur.
Au début, les utilisateurs pouvaient créé des fichiers, mais pas les supprimer.
Nous avons d'abord tenté de modifier l'Umask, sans effet.
Après beaucoup de recherches, nous avons découvert que la directive AllowOverwrite était désactivée par défaut. Le problème a été régler une fois activé.
- Problème du réseau avec les ports passifs.
Le plus gros problème a été avec les ports passifs, malgré la configuration de Docker et de ProFTPd, nous ne pouvions pas les l'atteindre depuis l'extérieur du serveur.
Après des heurts de recherche, nous avons enfin trouvé la directive nécessaire pour les faire marcher.
Le problème étant qu'il essaye d'ouvrir les ports sur la mauvaise adresse, une adresse locale au conteneur.

## Resultat

Après une journée de configuration, nous avons 3 scripts :
- un pour créer et lancer le conteneur.
- Un pour aller en mode interactive.
- Un pour supprimer le conteneur.

Pour modifier les utilisateurs, il faut modifier le Dockerfile.

## Conclution

En conclusion, nous avons créé un système de partage de fichiers basé sur la technique FTP.
Après avoir rencontré plusieurs problèmes, nous avons conteneur très simple à utiliser et à modifier.
