#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

if [ $# -eq 0 ]
then
    echo "Error!!! -> Specify conda path in argv1. Example: ./install.sh /usr/local/anaconda3/. Ending up the directory with a / is mandatory but I dont check it explicitely."
fi

conda_path=$1

echo "I am exiting the script for the following reason: this config files might need you to configure first a VPN or any other stuff since your config files might execute ssh in protected networks. Once
you are sure you have make all this set up that is hard do do within a general script (you might have different VPNs etc) then remove this sentence and the following exit. Also remember to sudo apt-get install git before running this since you are likely to have your set up in a github repository."
exit 1

apt-get autoremove -y
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get --purge autoremove -y
apt-get autoclean

## Install ubuntu packages
apt-get install -y vim git openssh-server curl trash-cli git-extras thunderbird network-manager-vpnc-gnome deja-dup usb-creator-gtk gparted htop

if [ "$?" -eq "1" ]; then
    echo "The apt-get install failed"
    exit 1
fi

## Install packages not directly comming from apt-get

# R
add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
apt update
apt install r-base -y

if [ "$?" -eq "1" ]; then
    echo "Installing R failed"
    exit 1
fi

# skype
wget  https://go.skype.com/skypeforlinux-64.deb -O /tmp/skypeforlinux-64.deb
apt install /tmp/skypeforlinux-64.deb -y

if [ "$?" -eq "1" ]; then
    echo "Installing skype failed"
    exit 1
fi

# zoom
wget https://zoom.us/client/latest/zoom_amd64.deb -O /tmp/zoom_amd64.deb
apt install /tmp/zoom_amd64.deb -y

if [ "$?" -eq "1" ]; then
    echo "Installing zoom failed"
    exit 1
fi

# teams
wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.3.00.5153_amd64.deb -O /tmp/teams.deb 
apt install /tmp/teams.deb -y

if [ "$?" -eq "1" ]; then
    echo "Installing teams failed"
    exit 1
fi

# spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
apt update
apt install spotify-client -y

if [ "$?" -eq "1" ]; then
    echo "Installing spotify failed"
    exit 1
fi

## Install anaconda
curl -o /tmp/Anaconda3-2021.11-Linux-x86_64.sh https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh   

if ! sha256sum -c ./sha256sum_check.md5; then
    echo "Anaconda checksum failed." 
    exit 1
fi

chmod +x /tmp/Anaconda3-2021.11-Linux-x86_64.sh
bash /tmp/Anaconda3-2021.11-Linux-x86_64.sh -b -p $conda_path

if [ "$?" -eq "1" ]; then
    echo "Installing conda failed"
    exit 1
fi

$conda_path/bin/conda update conda -y

if [ "$?" -eq "1" ]; then
    echo "Updating conda failed"
    exit 1
fi

exit 0
