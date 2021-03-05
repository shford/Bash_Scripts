#!/bin/bash

#author  : Hampton Ford
#purpose : Quick Linux copy-pasta for printing arrays in some string format

declare -a arr=(
account-plugin-aim
account-plugin-facebook
account-plugin-flickr
account-plugin-jabber
account-plugin-salut
account-plugin-yahoo
aisleriot
gnome-mahjongg
gnome-mines
gnome-sudoku
landscape-client-ui-install
unity-lens-music
unity-lens-photos
unity-lens-video
unity-scope-audacious
unity-scope-chromiumbookmarks
unity-scope-clementine
unity-scope-colourlovers
unity-scope-devhelp
unity-scope-firefoxbookmarks
unity-scope-gmusicbrowser
unity-scope-gourmet
unity-scope-guayadeque
unity-scope-musicstores
unity-scope-musique
unity-scope-openclipart
unity-scope-texdoc
unity-scope-tomboy
unity-scope-video-remote
unity-scope-virtualbox
unity-scope-zotero
unity-webapps-common)

for item in "${arr[@]}"
do
	echo "some_action $item"
done
