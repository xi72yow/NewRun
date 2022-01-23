#!/bin/bash
#chmod +x make script

sudo add-apt-repository multiverse
sudo add-apt-repository universe
sudo add-apt-repository ppa:tatokis/ckb-next

sudo apt update
sudo apt upgrade

#dependencies
sudo apt install curl jq wget unzip sed git -y
sudo apt install snapd -y

#pimp nautilus with encryption
sudo apt install seahorse-nautilus -y
nautilus -q

#FlashPrint
curl --location --output FlashPrint_amd64.deb --write-out "%{url_effective}\n" "https://en.fss.flashforge.com/10000/software/073e21bbe6ba5c7defb17dbb69708fd8.deb"
sudo apt install ./FlashPrint_amd64.deb -y

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
sudo apt install ckb-next qjoypad -y #qjoypad --notray

#Audio
#Audio Record Pipeline: sox -t alsa default test.wav --> mplayer test.wav
sudo apt install alsa alsa-tools sox mplayer kid3 -y
#ffmpeg Example: Audio: ffmpeg -i input.wav -vn -ar 44100 -ac 2 -b:a 320k output.mp3 Video: ffmpeg -i myvideo.mp4 -b:a 320k output.mp3
sudo apt install ffmpeg -y

#Multimedia
sudo apt install octave openshot-qt blender gparted ktorrent lmms flameshot mumble birdfont filezilla obs-studio inkscape pdfmod handbrake libfdk-aac1 libdvd-pkg -y
sudo dpkg-reconfigure libdvd-pkg -y

#Insync
curl https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.6.1.50206-focal_amd64.deb --output Incync_amd64.deb
sudo apt install ./Incync_amd64.deb -y

#Prepros
curl --location --output Prepros_amd64.deb --write-out "%{url_effective}\n" "https://prepros.io/downloads/stable/linux"
sudo apt install ./Prepros_amd64.deb -y

#node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash -y
nvm install --lts -y

#Latex
sudo apt install texlive-base -y 

#Set Gnome 3 Optical Suff
gsettings set org.gnome.desktop.background picture-uri "file://$PWD/XSmileWhite.png"
#gsettings set org.gnome.desktop.interface text-scaling-factor 1.2
gsettings set org.gnome.desktop.interface clock-format "24h"
gsettings set org.gnome.desktop.interface gtk-theme 'Pop-dark'
#keybindings save dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > dump_keybindings
cat dump_keybindings | dconf load /org/gnome/settings-daemon/plugins/media-keys/

#Keymapper
download_URL=$(get_URL_from_latest_release_for_deb "sezanzeb/key-mapper")
curl --location --output key-mapper.deb --write-out "%{url_effective}\n" $download_URL
sudo apt install ./key-mapper.deb -y

#Display Config
curl --location --output DisplayConfig.zip --write-out "%{url_effective}\n" "https://github.com/xi72yow/DisplayConfig/archive/refs/heads/main.zip"
unzip -q DisplayConfig.zip -d ~/.local/share/gnome-shell/extensions/
gnome-extensions enable "DisplayConfig";

#restart Gnome Shell
busctl --user call "org.gnome.Shell" "/org/gnome/Shell" "org.gnome.Shell" "Eval" "s" 'Meta.restart("Restarting…")';
