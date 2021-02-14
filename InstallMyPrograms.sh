#!/bin/bash
#chmod +x make script

sudo add-apt-repository multiverse
sudo add-apt-repository universe
sudo -i

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install curl

#Steam
sudo apt install steam

#VSCode
curl --location --output VS_Code_amd64.deb --write-out "%{url_effective}\n" "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install ./code_latest_amd64.deb

#Github Desktop (Not Official)
wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo tee /etc/apt/trusted.gpg.d/shiftkey-desktop.asc >/dev/null
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftky-desktop.list'
sudo apt-get update
sudo apt install github-desktop

#Chrome
curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output Chrome_amd64.deb
sudo apt install ./Chrome_amd64.deb

#Discord
curl --location --output Discord_amd64.deb --write-out "%{url_effective}\n" "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install ./Discord_amd64.deb

#CKB-Next Keyboard/Mouse setup
sudo apt install build-essential cmake libudev-dev qt5-default zlib1g-dev libpulse-dev libquazip5-dev libqt5x11extras5-dev libxcb-screensaver0-dev libxcb-ewmh-dev libxcb1-dev qttools5-dev git libdbusmenu-qt5-dev

#freac CD Ripper
sudo apt-get install libfdk-aac1
#sudo apt-get install libfdk-aac2 #ab20.10

sudo apt-get install openshot-qt lmms flameshot mumble audacity birdfont filezilla obs-studio inkscape -y
sudo apt-get install octave octave-doc gnuplot 

#Insync
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C
cd /etc/apt/sources.list.d/
printf 'deb http://apt.insync.io/ubuntu Focal Fossa non-free contrib' > insync.list #maybe FocalFosse together??
sudo apt-get update
sudo apt-get install insync