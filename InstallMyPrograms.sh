#!/bin/bash
#chmod +x make script

#For Vanilla Ubuntu/Server Version
sudo apt-get install zenity 
sudo add-apt-repository ppa:gnome3-team/gnome3
sudo apt-get update && sudo apt-get install gnome-shell ubuntu-gnome-desktop
####

sudo add-apt-repository multiverse
sudo add-apt-repository universe
sudo add-apt-repository ppa:tatokis/ckb-next

sudo apt update
sudo apt upgrade

#dependencies
sudo apt install curl jq wget unzip sed -y

#Steam
curl --location --output Steam_amd64.deb --write-out "%{url_effective}\n" "https://repo.steampowered.com/steam/archive/stable/steam_latest.deb"
sudo apt install ./Steam_amd64.deb -y

#VSCode
curl --location --output VS_Code_amd64.deb --write-out "%{url_effective}\n" "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install ./VS_Code_amd64.deb -y

#Github Desktop "Not Official" 
get_URL_from_latest_release_for_deb() {
    local resultURLs=$(curl "https://api.github.com/repos/$1/releases" | # Get release from GitHub api
        jq '[.[].assets] | .[0]')                                        

    for variable in $resultURLs; do
        if [[ $variable == *".deb"* ]]; then
            if [[ $variable == *"https:"* ]]; then # Get download URL
                urlSize="$((${#variable} - 1))" 
                echo $variable | cut -c2-$urlSize # Delete the ""
            fi
        fi
    done
}

download_URL=$(get_URL_from_latest_release_for_deb "shiftkey/desktop")
curl --location --output Github_Desktop_amd64.deb --write-out "%{url_effective}\n" $download_URL
sudo apt install ./Github_Desktop_amd64.deb -y

#Chrome
curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output Chrome_amd64.deb
sudo apt install ./Chrome_amd64.deb -y

#Discord
curl --location --output Discord_amd64.deb --write-out "%{url_effective}\n" "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install ./Discord_amd64.deb -y

#CKB-Next Keyboard/Mouse setup
sudo apt install ckb-next

#Audio
#Audio Record Pipeline: sox -t alsa default test.wav --> mplayer test.wav
sudo apt install alsamixer sox mplayer -y
#ffmpeg Example: Audio: ffmpeg -i input.wav -vn -ar 44100 -ac 2 -b:a 320k output.mp3 Video: ffmpeg -i myvideo.mp4 -b:a 320k output.mp3
sudo apt install ffmpeg -y
#freac CD Ripper
sudo apt install libfdk-aac1 -y
#sudo apt-get install libfdk-aac2 #ab20.10

#Multimedia
sudo apt install openshot-qt blender GParted ktorrent lmms flameshot mumble birdfont filezilla obs-studio inkscape -y

#Insync Install Not sure that is in every case the newest Version
curl https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.3.6.40933-focal_amd64.deb --output Incync_amd64.deb
sudo apt install ./Incync_amd64.deb -y

#Prepros
curl --location --output Prepros_amd64.deb --write-out "%{url_effective}\n" "https://prepros.io/downloads/stable/linux"
sudo apt install ./Prepros_amd64.deb -y

#Set Gnome 3 Optical Suff
gsettings set org.gnome.desktop.background picture-uri "file://$PWD/XSmileWhite.png"
gsettings set org.gnome.desktop.interface clock-format "24h"
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

#VM
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager -y
#Insync do not work LEL
##apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C
##cd /etc/apt/sources.list.d/
##printf 'deb http://apt.insync.io/ubuntu Focal Fossa non-free contrib' >insync.list #maybe FocalFosse together??
##sudo apt-get update
##sudo apt-get install insync