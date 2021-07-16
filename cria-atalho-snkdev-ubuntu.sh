#!/bin/bash

optDir=/opt/eclipse-snkdev

if [[ ! -d $optDir ]];
then
    sudo mkdir $optDir
fi

sudo wget -P $optdir  https://raw.githubusercontent.com/computeiro/eclipse-snkdev/main//docs/eclipse-icon.xpm
sudo wget -P /usr/share/applications https://raw.githubusercontent.com/computeiro/eclipse-snkdev/main/eclipse-snkdev.desktop