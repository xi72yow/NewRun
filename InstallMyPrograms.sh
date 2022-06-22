#!/bin/bash
#chmod +x make script

#ubuntu
sudo add-apt-repository multiverse
sudo add-apt-repository universe
sudo add-apt-repository ppa:tatokis/ckb-next

sudo apt update
sudo apt upgrade

#debian
sudo cp ./files/sources.list /etc/apt/
sudo sed -i 's/bullseye\/updates/bullseye-security/g' /etc/apt/sources.list

sudo apt update
sudo apt upgrade

#dependencies
sudo apt install curl jq wget unzip sed git xdotool -y
sudo apt install snapd -y
sudo dpkg --add-architecture i386

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

get_URL_from_latest_release_for_AppImage() {
    local resultURLs=$(curl "https://api.github.com/repos/$1/releases" | # Get release from GitHub api
        jq '[.[].assets] | .[0]')

    for variable in $resultURLs; do
        if [[ $variable == *".AppImage"* ]]; then
            if [[ $variable == *"https:"* ]]; then # Get download URL
                urlSize="$((${#variable} - 1))"
                echo $variable | cut -c2-$urlSize # Delete the ""
            fi
        fi
    done
}

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

#cp ./Code/snippets/javascript/log.code-snippets ~/.config/Code/User/snippets/log.code-snippets
#cp ./Code/shortcuts/keybindings.json ~/.config/Code/User/shortcuts/keybindings.json

#Github Desktop "Not Official"
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
sudo apt install ckb-next #qjoypad -y #qjoypad --notray #map mouse and keyboard to controller

download_URL=$(get_URL_from_latest_release_for_deb "sezanzeb/input-remapper")
curl --location --output remapper_amd64.deb --write-out "%{url_effective}\n" $download_URL
sudo apt install ./remapper_amd64.deb -y

#Audio
#Audio Record Pipeline: sox -t alsa default test.wav --> mplayer test.wav
sudo apt install alsa alsa-tools sox mplayer kid3 -y
#ffmpeg Example: Audio: ffmpeg -i input.wav -vn -ar 44100 -ac 2 -b:a 320k output.mp3 Video: ffmpeg -i myvideo.mp4 -b:a 320k output.mp3
sudo apt install ffmpeg -y

#Multimedia simplescreenrecorder when obs is buggy
sudo apt install gdebi libreoffice libreoffice-l10n-de libreoffice-help-de clamtk-gnome octave openshot-qt blender g3dviewer gparted ktorrent lmms flameshot birdfont filezilla obs-studio inkscape handbrake libfdk-aac1 libdvd-pkg -y
sudo dpkg-reconfigure libdvd-pkg -y

#Lightworks
curl https://cdn.lwks.com/releases/2022.1.1/lightworks_2022.1.1_r132926.deb --output lightworks_amd64.deb
sudo apt install ./lightworks_amd64.deb -y

#Insync
curl https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.7.9.50368-bullseye_amd64.deb --output Incync_amd64.deb
sudo apt install ./Incync_amd64.deb -y

#Prepros
curl --location --output Prepros_amd64.deb --write-out "%{url_effective}\n" "https://prepros.io/downloads/stable/linux"
sudo apt install ./Prepros_amd64.deb -y

#node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 
nvm install --lts 

#Latex
sudo apt install texlive-full inotify-tools qpdf xournal -y

#Popslice
download_URL=$(get_URL_from_latest_release_for_AppImage "pop-os/popsicle")
curl --location --output popsicle_amd64.AppImage --write-out "%{url_effective}\n" $download_URL
chmod a+x popsicle_amd64.AppImage
cp ./apps/com.system76.Popsicle.desktop /usr/share/applications

#ProtonVPN
curl https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb --output ProtonVPN_amd64.deb
sudo apt install ./VS_Code_amd64.deb -y
sudo apt update
sudo apt install protonvpn -y

#stuff
#xournalpp currently not working for me
#download_URL=$(get_URL_from_latest_release_for_deb "xournalpp/xournalpp")
#curl --location --output xournalpp_amd64.deb --write-out "%{url_effective}\n" $download_URL
#sudo apt install ./xournalpp_amd64.deb -y
#sudo apt install clamav clamav-freshclam

#Set Gnome 3 Optical Suff
gsettings set org.gnome.desktop.background picture-uri "file://$PWD/XSmileWhite.png"
#gsettings set org.gnome.desktop.interface text-scaling-factor 1.2
gsettings set org.gnome.desktop.interface clock-format "24h"
gsettings set org.gnome.desktop.interface gtk-theme 'Pop-dark'
#keybindings save dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > dump_keybindings
cat dump_keybindings | dconf load /org/gnome/settings-daemon/plugins/media-keys/

#AppIndicator
sudo apt install gnome-shell-extension-appindicator gir1.2-appindicator3-0.1
#default displays manager
grep '/usr/s\?bin' /etc/systemd/system/display-manager.service

#Display Config
curl --location --output DisplayConfig.zip --write-out "%{url_effective}\n" "https://github.com/xi72yow/DisplayConfig/archive/refs/heads/main.zip"
unzip -q DisplayConfig.zip -d ~/.local/share/gnome-shell/extensions/
gnome-extensions enable "DisplayConfig"

#restart Gnome Shell
busctl --user call "org.gnome.Shell" "/org/gnome/Shell" "org.gnome.Shell" "Eval" "s" 'Meta.restart("Restarting…")'
