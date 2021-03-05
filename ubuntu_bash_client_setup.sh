#!/bin/bash

#author  :  Hampton Ford
#purpose :  Downloads common packages that *I* use and removes/replaces excess packages 
#        :  including replacing Snap with Flak. Comment out what you don't like.
#notes   :  Meant to automate setup after fresh install.

#ensure sleep function is present
apt install -y coreutils
clear

#instructions
echo "Common Packages Installer"
echo
echo "Before running it is recommended that you first install driver updates manually or with another tool."
echo
echo "Run as root with internet connectivity to continue."
echo "You have 5 seconds to cancel. ^Ctrl+C"

sleep 5s

#=======================================================================================================
### Check Conditions ###
#=======================================================================================================
#ensure root privilege
if [[ $((id -u)) -ne 0 ]]; then
   echo "This script must be run as root." 
   exit 1
fi

#check network connection
ping -c1 "8.8.8.8" >& "/dev/null"

if [[ "${?}" -ne 0 ]]; then
	echo "No internet connection."; exit;
fi

#=======================================================================================================
### Add PPAs as Needed ###
#=======================================================================================================
#sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt install -y apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

#qBittorent
add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable

#=======================================================================================================
### Downloads ###
#=======================================================================================================
#update
apt update

#update kernel headers
apt install -y linux-headers-$(uname -r)

#install gcc
apt install -y gcc

#install make
apt install -y make

#install cmake
apt install -y cmake

#install ifconfig
apt install -y net-tools

#install openssh
apt install -y openssh-client

#install pip3
apt install -y python3-pip

#install mlocate
apt install -y mlocate

#install debconf-get-selections
apt install -y debconf-utils

#install wpa_supplicant
apt install -y wpasupplicant

#install pstree
apt install -y psmisc

#install git
apt install -y git

#install sshguard
apt install -y sshguard

#install iptables-persistent non-interactive
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
apt install -y iptables-persistent ufw

#install ufw
apt install -y ufw

#install wireshark
echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt install -y wireshark

#install aircrack
apt install -y aircrack-ng

#install sublime editor
apt install -y sublime-text

#install qbittorrent b/c open source torrenting is just better
apt install -y qbittorrent

#install gparted
apt install -y gparted

#install chrome if not already installed (actually this will pass incorrectly if there are config files on disk but that's fine for the purpose of this script)
dpkg -l "google-chrome-stable" >& "/dev/null"
#if [[ "${?}" -ne 0 ]]; then
	#download package
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	apt install -y ./google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb
#fi

#install vlc media player
apt install -y vlc

#install flatpak
apt install -y flatpak


#=======================================================================================================
### Remove Packages ###
#=======================================================================================================
read -p "Would you like to remove packages? " CHOICE;
if [[ !("${CHOICE}" == "y" || "${CHOICE}" == "Y" || "${CHOICE}" == "Yes" || "${CHOICE}" == "YES") ]]; then
	echo "Will not remove packages. Exiting..."; exit;
else
	apt remove snapd
	apt purge account-plugin-aim
	apt purge account-plugin-facebook
	apt purge account-plugin-flickr
	apt purge account-plugin-jabber
	apt purge account-plugin-salut
	apt purge account-plugin-yahoo
	apt purge aisleriot
	apt purge gnome-mahjongg
	apt purge gnome-mines
	apt purge gnome-sudoku
	apt purge landscape-client-ui-install
	apt purge unity-lens-music
	apt purge unity-lens-photos
	apt purge unity-lens-video
	apt purge unity-scope-audacious
	apt purge unity-scope-chromiumbookmarks
	apt purge unity-scope-clementine
	apt purge unity-scope-colourlovers
	apt purge unity-scope-devhelp
	apt purge unity-scope-firefoxbookmarks
	apt purge unity-scope-gmusicbrowser
	apt purge unity-scope-gourmet
	apt purge unity-scope-guayadeque
	apt purge unity-scope-musicstores
	apt purge unity-scope-musique
	apt purge unity-scope-openclipart
	apt purge unity-scope-texdoc
	apt purge unity-scope-tomboy
	apt purge unity-scope-video-remote
	apt purge unity-scope-virtualbox
	apt purge unity-scope-zotero
	apt purge unity-webapps-common
fi
