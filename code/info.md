VSCode sync:
https://code.visualstudio.com/docs/editor/settings-sync


Change to Gnome Debian
sudo apt install gdebi to install

https://www.enovision.net/how-create-appimage-entries-menu-ubuntu
https://github.com/pop-os/popsicle/releases/download/1.3.0/Popsicle_USB_Flasher-1.3.0-x86_64.AppImage
https://raw.githubusercontent.com/pop-os/popsicle/master/gtk/assets/icons/512x512%402x/apps/com.system76.Popsicle.png

https://www.gnome-look.org/p/1334194/

sudo nano /etc/apt/sources.list
 
deb http://deb.debian.org/debian bullseye main contrib non-free
deb-src http://deb.debian.org/debian bullseye main contrib non-free
deb http://deb.debian.org/debian-security bullseye/updates main contrib non-free
deb-src http://deb.debian.org/debian-security bullseye/updates main contrib non-free
deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free
 
sudo sed -i 's/bullseye\/updates/bullseye-security/g' /etc/apt/sources.list
 
sudo apt update 
